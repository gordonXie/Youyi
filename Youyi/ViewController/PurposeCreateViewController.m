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

#define KTableCellHeight 36.0
#define KTableCellLeftSpace 15.0

@interface PurposeCreateViewController ()<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView    *_baseScrollView;
    UITextField     *_nameTF;
    UITextField     *_styleTF;
    UITextView      *_descriptionTV;
    
    UITableView     *_tableView;
    
    //for PickerView
    UIPickerView    *_durationPickerView;
    UIPickerView    *_cyclePickerView;
    
    NSArray         *_durationArray;
    NSArray         *_cycleArray;
    NSArray         *_timeArray;
    
    BOOL            _isShowDurationPicker;
    BOOL            _isShowCyclePicker;
}
@end

@implementation PurposeCreateViewController
@synthesize timeSectionEnd;
@synthesize timeSectionStart;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initViews
{
    [super initViews];
    [self setTitle:@"新建意向"];
    [self addBackBtn:@"返回"];
    [self addRightBtn:@"保存"];
    
    _isShowDurationPicker = NO;
    
    [self addBaseScrollView];
}

- (void)addBaseScrollView
{
    _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_baseScrollView];
    
    [self addTableView];
}

- (void)addTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, CONTENT_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
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
                return KTableCellHeight*2+[XCommon heightForString:_descriptionTV.text fontSize:17.0 andWidth:SCREEN_WIDTH];
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
                if (_isShowDurationPicker) {
                    return KTableCellHeight*3;
                }
                return KTableCellHeight;
            }
                break;
            case 2:
            {
                if (_isShowCyclePicker) {
                    return KTableCellHeight*3;
                }
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
    if (section==1&&(_isShowDurationPicker||_isShowCyclePicker)) {
        return 4;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
                }
                    break;
                case 1:
                {
                    if (_isShowDurationPicker) {
                        cell.textLabel.text = @"";
                        [cell addSubview:[self durationPickerViewForCell]];
                    }else{
                        cell.textLabel.text = @"重复";
                        _durationPickerView.hidden = YES;
                    }
                }
                    break;
                case 2:
                {
                    if (_isShowDurationPicker) {
                        cell.textLabel.text = @"重复";
                    }else if (_isShowCyclePicker) {
                        cell.textLabel.text = @"";
                        [cell addSubview:[self cyclePickerViewForCell]];
                    }else{
                        cell.textLabel.text = @"时段";
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        _cyclePickerView.hidden = YES;
                    }
                }
                    break;
                case 3:
                {
                    if (_isShowDurationPicker||_isShowCyclePicker) {
                        cell.textLabel.text = @"时段";
                    }else{
                        [cell removeFromSuperview];
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
    UIView *baseView;
    if (_descriptionTV==nil) {
        baseView = [[UIView alloc]initWithFrame:CGRectMake(KTableCellLeftSpace, 0, SCREEN_WIDTH-KTableCellLeftSpace, KTableCellHeight*3)];
        UILabel *decLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, KTableCellHeight)];
        decLbl.font = [UIFont systemFontOfSize:15.0];
        decLbl.text = @"描述:";
        [baseView addSubview:decLbl];
        
        CGRect desRect = CGRectMake(0, KTableCellHeight, baseView.frame.size.width, KTableCellHeight);
        _descriptionTV = [[UITextView alloc]initWithFrame:desRect];
        [_descriptionTV setBackgroundColor:[UIColor clearColor]];
        _descriptionTV.delegate = self;
        _descriptionTV.font = [UIFont systemFontOfSize:KCellFontSizeCommon];
        [baseView addSubview:_descriptionTV];
    }
    baseView.hidden = NO;
    
    return baseView;
}

- (UIView*)durationPickerViewForCell
{
    if (_durationPickerView==nil) {
        _durationArray = [[NSArray alloc]initWithObjects:@"两周",@"三周",@"一个月",@"两个月",@"三个月",@"六个月", nil];
        
        _durationPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, -KTableCellHeight+10, SCREEN_WIDTH, KTableCellHeight)];
        _durationPickerView.dataSource = self;
        _durationPickerView.delegate = self;
        _durationPickerView.showsSelectionIndicator = YES;
    }
    _durationPickerView.hidden = NO;

    return _durationPickerView;
}

- (UIView*)cyclePickerViewForCell
{
    if (_cyclePickerView==nil) {
        //重复(以天为单位) 可选择:每天，每两天，每三天，每周，每两周，每月
        _cycleArray = [[NSArray alloc]initWithObjects:@"每天",@"每两天",@"每三天",@"每周",@"每两周",@"每月", nil];
        
        _cyclePickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, -KTableCellHeight+10, SCREEN_WIDTH, KTableCellHeight)];
        _cyclePickerView.dataSource = self;
        _cyclePickerView.delegate = self;
        _cyclePickerView.showsSelectionIndicator = YES;
    }
    _cyclePickerView.hidden = NO;
    
    return _cyclePickerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
        if (indexPath.row==0) {  //持续时间
            if (!_isShowDurationPicker) {
                //显示_durationPickerView
                [self restoreTableView];
                
                _isShowDurationPicker = YES;
                [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:nextIndexPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
            }else{
                //隐藏_durationPickerView
                _isShowDurationPicker = NO;
                [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:nextIndexPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
                _durationPickerView.hidden = YES;
            }
        }
        
        else if((indexPath.row==1&&!_isShowDurationPicker)||(_isShowDurationPicker&&indexPath.row==2)){  //重复
            nextIndexPath = [NSIndexPath indexPathForRow:2 inSection:1];  //当showDuration时，如果不重置，nextIndexPath的row为3，位置不对。应该总是2
            if (!_isShowCyclePicker) {
                [self restoreTableView];
                
                _isShowCyclePicker = YES;
                [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:nextIndexPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
            }else{
                _isShowCyclePicker = NO;
                [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:nextIndexPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
                _cyclePickerView.hidden = YES;
            }
        }
        
        else if((indexPath.row==2&&!_isShowDurationPicker&&!_isShowCyclePicker)||((_isShowCyclePicker||_isShowDurationPicker)&&indexPath.row==3)){
            PurposeTimeSetViewController *setTimeVC = [[PurposeTimeSetViewController alloc]init];
            [appDelegate.navController pushViewController:setTimeVC animated:YES];
        }
    }
}

#pragma mark - 还原tableView，隐私显示的pickerView
- (void)restoreTableView
{
    if (_isShowDurationPicker) {
        _isShowDurationPicker = NO;
        NSIndexPath *pickerIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:pickerIndexPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
        _durationPickerView.hidden = YES;
    }
    if (_isShowCyclePicker) {
        _isShowCyclePicker = NO;
        NSIndexPath *pickerIndexPath = [NSIndexPath indexPathForRow:2 inSection:1];
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:pickerIndexPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
        _cyclePickerView.hidden = YES;
    }
}

- (void)selectPickerView
{
    NSString *rangeStr;
    if ([XCommon isNullString:[XCommon UserDefaultGetValueFromKey:SEARCHRANGE]]) {
        rangeStr = KDefaultSearchRange;
    }else
        rangeStr = [XCommon UserDefaultGetValueFromKey:SEARCHRANGE];
//    for (int i=0;i<_rangeArray.count;i++) {
//        if ([[_rangeArray objectAtIndex:i] isEqualToString:rangeStr]) {
//            [_pickerView selectRow:i inComponent:0 animated:NO];
//            break;
//        }
//    }
}


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
@end
