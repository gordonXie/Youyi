//
//  PurposeCreateViewController.m
//  Youyi
//
//  Created by xieguocheng on 14-11-6.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "PurposeCreateViewController.h"
#import "UITextField+LabelAndImage.h"
#import "PurposeTimeSetViewController.h"
#import "JView_MyPicker.h"

#define KTableCellHeight 42.0
#define KTableCellLeftSpace 15.0
#define KDescTextViewFontSize 17.0

#define KTableCellTextColor @"#bebebe"

@interface PurposeCreateViewController ()<UITextFieldDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,JView_MyPickerDelegate>
{
    UIScrollView    *_baseScrollView;
    UITextField     *_nameTF;
    UITextField     *_styleTF;
    UITextView      *_descriptionTV;
    UITextField     *_descriptionTF;
    UIView          *_baseDescView;
    
    UITableView     *_tableView;
    
    //for PickerView
    JView_MyPicker    *_durationPickerView;
    JView_MyPicker    *_cyclePickerView;
    UILabel         *_durationLbl;
    UILabel         *_cycleLbl;
    UILabel         *_timeLbl;
    
    NSArray         *_durationArray;
    NSArray         *_cycleArray;
    
//    BOOL            _isShowDurationPicker;
//    BOOL            _isShowCyclePicker;
}
@end

@implementation PurposeCreateViewController
@synthesize timeSectionEnd = _timeSectionEnd;
@synthesize timeSectionStart = _timeSectionStart;
@synthesize homeVC;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initViews
{
    [super initViews];
    [self setTitle:@"新建意向"];
    [self addLeftBtn:@"返回"];
    [self addRightBtn:@"保存"];
    
    [self addBaseScrollView];
}

- (void)addBaseScrollView
{
    _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_baseScrollView];
    
    //持续时间
    _durationArray = [[NSArray alloc]initWithObjects:@"两周",@"三周",@"一个月",@"两个月",@"三个月",@"六个月", nil];
    //重复(以天为单位) 可选择:每天，每两天，每三天，每周，每两周，每月
    _cycleArray = [[NSArray alloc]initWithObjects:@"每天",@"每两天",@"每三天",@"每周",@"每两周",@"每月", nil];
    _timeSectionStart = @"6:00";
    _timeSectionEnd = @"22:00";
    
    [self addTableView];
}

- (void)addTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, CONTENT_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_timeLbl) {
        _timeLbl.text = [NSString stringWithFormat:@"%@-%@",_timeSectionStart,_timeSectionEnd];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            case 1:
            {
                return KTableCellHeight;
            }
                break;
            case 2:
            {
                return KTableCellHeight*2+[XCommon heightForString:_descriptionTV.text fontSize:KDescTextViewFontSize andWidth:SCREEN_WIDTH-KTableCellLeftSpace];
            }
                
            default:
                break;
        }
    }else if(indexPath.section==1){
        switch (indexPath.row) {
            case 0:
            {
                return KTableCellHeight;
            }
                break;
            case 1:
            {
                return KTableCellHeight;
            }
                break;
            case 2:
            {
                return KTableCellHeight;
            }
            case 3:
            {
                return KTableCellHeight;
            }
                break;
                
            default:
                break;
        }
    }
    
    return KTableCellHeight;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
//    for (UIView* view in [cell subviews]) {
//        view.hidden = YES;
//    }
//    cell.textLabel.hidden = NO;
    cell.textLabel.text = @"";
    
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                if (_nameTF==nil) {
                    _nameTF = [[UITextField alloc]initWithFrame:CGRectMake(KTableCellLeftSpace, 0, SCREEN_WIDTH-KTableCellLeftSpace, KTableCellHeight)];
                    [_nameTF setBackgroundColor:[UIColor clearColor]];
                    _nameTF.placeholder = @"9个字以内";
                    _nameTF.delegate = self;
                    _nameTF.returnKeyType = UIReturnKeyDone;
                    [_nameTF setLeftLabelWithText:@"名称:  "];
                }
                _nameTF.hidden = NO;
                [cell addSubview:_nameTF];
            }
                break;
            case 1:
            {
                if (_styleTF==nil) {
                    _styleTF = [[UITextField alloc]initWithFrame:CGRectMake(KTableCellLeftSpace, 0, SCREEN_WIDTH-KTableCellLeftSpace, KTableCellHeight)];
                    [_styleTF setBackgroundColor:[UIColor clearColor]];
                    _styleTF.placeholder = @"显示个性";
                    _styleTF.delegate = self;
                    _styleTF.returnKeyType = UIReturnKeyDone;
                    [_styleTF setLeftLabelWithText:@"action:  "];
                }
                _styleTF.hidden = NO;
                [cell addSubview:_styleTF];
            }
                break;
            case 2:
            {
                [cell addSubview:[self descriptionCellView]];
            }
                break;
            default:
                break;
        }
    }
    
    if (indexPath.section==1) {
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"持续时间";
                    if (_durationLbl==nil) {
                        _durationLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-KTableCellLeftSpace, KTableCellHeight)];
                        _durationLbl.text = [_durationArray objectAtIndex:0];
                        _durationLbl.textAlignment = NSTextAlignmentRight;
                        _durationLbl.textColor = [XCommon hexStringToColor:KTableCellTextColor];
                        [cell addSubview:_durationLbl];
                    }
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"重复";
                    if (_cycleLbl==nil) {
                        _cycleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-KTableCellLeftSpace, KTableCellHeight)];
                        _cycleLbl.text = [_cycleArray objectAtIndex:0];
                        _cycleLbl.textAlignment = NSTextAlignmentRight;
                        _cycleLbl.textColor = [XCommon hexStringToColor:KTableCellTextColor];
                        [cell addSubview:_cycleLbl];
                    }else{
                        _cycleLbl.hidden = NO;
                    }
                    
                }
                    break;
                case 2:
                {
                    cell.textLabel.text = @"时段";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    _cyclePickerView.hidden = YES;
                    
                    if (_timeLbl==nil) {
                        _timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-KTableCellLeftSpace*2, KTableCellHeight)];
                        _timeLbl.text = [NSString stringWithFormat:@"%@-%@",_timeSectionStart,_timeSectionEnd];
                        _timeLbl.textAlignment = NSTextAlignmentRight;
                        _timeLbl.textColor = [XCommon hexStringToColor:KTableCellTextColor];
                        [cell addSubview:_timeLbl];
                    }
                    
                }
                    break;
                default:
                    break;
            }
    }
    
    return cell;
}

-(UIView*)descriptionCellView
{
    if (_baseDescView==nil) {
        _baseDescView = [[UIView alloc]initWithFrame:CGRectMake(KTableCellLeftSpace, 0, SCREEN_WIDTH-KTableCellLeftSpace, KTableCellHeight*3)];
        UILabel *decLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, KTableCellHeight)];
        decLbl.font = [UIFont systemFontOfSize:15.0];
        decLbl.text = @"描述:";
        [_baseDescView addSubview:decLbl];
        
//        UITextField
        
        CGRect desRect = CGRectMake(0, KTableCellHeight, _baseDescView.frame.size.width, 30.0);
        _descriptionTV = [[UITextView alloc]initWithFrame:desRect];
        [_descriptionTV setBackgroundColor:[UIColor clearColor]];
        _descriptionTV.delegate = self;
        _descriptionTV.scrollEnabled = NO;
        _descriptionTV.bounces = NO;
        _descriptionTV.font = [UIFont systemFontOfSize:KDescTextViewFontSize];
        _descriptionTV.returnKeyType = UIReturnKeyDone;
        [_baseDescView addSubview:_descriptionTV];
    }else{
        [_descriptionTV setFrame:CGRectMake(_descriptionTV.frame.origin.x, _descriptionTV.frame.origin.y, _descriptionTV.frame.size.width, [XCommon heightForString:_descriptionTV.text fontSize:KDescTextViewFontSize andWidth:_descriptionTV.frame.size.width])];

        [_descriptionTV becomeFirstResponder];

    }
    
    return _baseDescView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==1) {
        if (indexPath.row==0) {  //持续时间
            [self showDurationPickerView];
        }
        else if(indexPath.row==1){  //重复
            [self showCyclePickerView];
        }
        else if(indexPath.row==2){
            PurposeTimeSetViewController *setTimeVC = [[PurposeTimeSetViewController alloc]init];
            setTimeVC.fromVC = self;
            [appDelegate.navController pushViewController:setTimeVC animated:YES];
        }
    }
}

//显示选择持续时间
- (void)showDurationPickerView
{
    if (!_durationPickerView) {
        _durationPickerView = [[JView_MyPicker alloc] init];
        _durationPickerView.delegate = self;
    }
    if (!_durationPickerView.dataSource) {
        _durationPickerView.dataSource = _durationArray;
    }
    [_durationPickerView show];
}

//显示选择周期时间
- (void)showCyclePickerView
{
    if (!_cyclePickerView) {
        _cyclePickerView = [[JView_MyPicker alloc] init];
        _cyclePickerView.delegate = self;
    }
    if (!_cyclePickerView.dataSource) {
        _cyclePickerView.dataSource = _cycleArray;
    }
    [_cyclePickerView show];
}

/*
#pragma mark - PickerViewDataSource
//以下3个方法实现PickerView的数据初始化
//确定picker的轮子个数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
//确定picker的每个轮子的item数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView==_durationPickerView) {
        return _durationArray.count;
    }else if(pickerView==_cyclePickerView){
        return _cycleArray.count;
    }
    return [_durationArray count];
}
//确定每个轮子的每一项显示什么内容
#pragma mark 实现协议UIPickerViewDelegate方法
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView==_durationPickerView) {
        return [_durationArray objectAtIndex:row];
    }else if(pickerView==_cyclePickerView){
        return [_cycleArray objectAtIndex:row];
    }
    return [_durationArray objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView==_durationPickerView) {
        _durationLbl.text =  [_durationArray objectAtIndex:row];
    }else if(pickerView==_cyclePickerView){
        _cycleLbl.text =  [_cycleArray objectAtIndex:row];
    }
}
*/
#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
}
- (void)textViewDidChange:(UITextView *)textView
{
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:2 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone ];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)onRightBtnClick:(id)sender
{
    if ([XCommon isNullString:_nameTF.text]) {
        [self.view makeToast:@"意向的名字不能为空"];
        return;
    }
}

#pragma mark - JView_MyPickerDelegate
- (void)JPickerDismiss:(JView_MyPicker *)picker cancel:(BOOL)cancel{
    if (!cancel) {
        NSInteger row = picker.didSelectRow;
        if (picker==_cyclePickerView) {
            _cycleLbl.text =  [_cycleArray objectAtIndex:row];
        }else{
            _durationLbl.text =  [_durationArray objectAtIndex:row];
        }
    }
}

@end
