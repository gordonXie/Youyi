//
//  PurposeCreateViewController.m
//  Youyi
//
//  Created by xieguocheng on 14-11-6.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "PurposeCreateViewController.h"
#import "UITextField+LabelAndImage.h"

#define KTableCellHeight 36.0
#define KTableCellLeftSpace 15.0

@interface PurposeCreateViewController ()<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView    *_baseScrollView;
    UITextField     *_nameTF;
    UITextField     *_actionTF;
    UITextView      *_descriptionTV;
//    UIDatePicker    *_startDate;
//    UIDatePicker    *_endDate;
    
    UITableView     *_tableView;
    
    //for PickerView
    UIPickerView    *_durationPickerView;
    UIPickerView    *_cyclePickerView;
    UIPickerView    *_startPickerView;
    UIPickerView    *_endPickerView;
    UIPickerView    *_timePickerView;
    
    NSArray         *_durationArray;
    NSArray         *_cycleArray;
    NSArray         *_timeArray;
    
    BOOL            _isShowDurationPicker;
    BOOL            _isShowCyclePicker;
    BOOL            _isShowTimePicker;
}
@end

@implementation PurposeCreateViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initViews
{
    [super initViews];
    [self setTitle:@"新建意向"];
    [self addBackBtn];
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
                if (_isShowTimePicker) {
                    return KTableCellHeight*3;
                }
                return KTableCellHeight;
            }
                break;
                
            default:
                break;
        }
    }
//    else{
//        switch (indexPath.row) {
//            case 0:
//            {
//                return KTableCellHeight;
//            }
//                break;
//            case 1:{
//                return KTableCellHeight*3;
//            }
//                break;
//            case 2:
//            {
//                return KTableCellHeight;
//            }
//                break;
//            case 3:
//            {
//                return KTableCellHeight*2+[XCommon heightForString:_descriptionTV.text fontSize:17.0 andWidth:SCREEN_WIDTH];
//            }
//                
//            default:
//                break;
//        }
//    }
    
    return KTableCellHeight;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1&&(_isShowDurationPicker||_isShowTimePicker||_isShowCyclePicker)) {
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
                if (_actionTF==nil) {
                    _actionTF = [[UITextField alloc]initWithFrame:CGRectMake(KTableCellLeftSpace, 0, SCREEN_WIDTH-KTableCellLeftSpace, KTableCellHeight)];
                    [_actionTF setBackgroundColor:[UIColor clearColor]];
                    _actionTF.placeholder = @"显示个性";
                    _actionTF.delegate = self;
                    [_actionTF setLeftLabelWithText:@"action:  "];
                }
                _actionTF.hidden = NO;
                [cell addSubview:_actionTF];
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
                        cell.textLabel.text = @"周期";
                        _durationPickerView.hidden = YES;
                    }
                }
                    break;
                case 2:
                {
                    if (_isShowCyclePicker) {
                        cell.textLabel.text = @"";
                        [cell addSubview:[self cyclePickerViewForCell]];
                    }else{
                        cell.textLabel.text = @"时间段";
                        _cyclePickerView.hidden = YES;
                    }
                }
                    break;
                case 3:
                {
                    if (_isShowTimePicker) {
                        cell.textLabel.text = @"";
                        [cell addSubview:[self cyclePickerViewForCell]];
                    }
                }
                    break;
                default:
                    break;
            }
//        
//        else{
//            switch (indexPath.row) {
//                case 0:
//                {
//                    cell.textLabel.text = @"持续时间";
//                }
//                    break;
//                case 1:
//                {
//                    cell.textLabel.text = @"";
//                    [cell addSubview:[self durationPickerViewForCell]];
//                }
//                    break;
//                case 2:
//                {
//                    cell.textLabel.text = @"周期";
//                }
//                    break;
//                case 3:
//                {
//                    cell.textLabel.text = @"时间段";
//                    //                    cell.detailTextLabel.text = @"周五";  //不显示
//                }
//                    break;
//                default:
//                    break;
//            }
//        }
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
        _descriptionTV.font = [UIFont systemFontOfSize:KTableCellFontCommon];
        [baseView addSubview:_descriptionTV];
    }
    baseView.hidden = NO;
    
    
    return baseView;
}

- (UIView*)durationPickerViewForCell
{
    if (_durationPickerView==nil) {
        _durationArray = [[NSArray alloc]initWithObjects:@"2周",@"3周",@"1个月",@"2个月",@"3个月",@"6个月", nil];
        
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
        //周期(以天为单位) 可选择:1天，2天，3天，1周，2周，1个月
        _cycleArray = [[NSArray alloc]initWithObjects:@"1天",@"2天",@"3天",@"1周",@"2周",@"1个月", nil];
        
        _cyclePickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, -KTableCellHeight+10, SCREEN_WIDTH, KTableCellHeight)];
        _cyclePickerView.dataSource = self;
        _cyclePickerView.delegate = self;
        _cyclePickerView.showsSelectionIndicator = YES;
    }
    _cyclePickerView.hidden = NO;
    
    return _cyclePickerView;
}

- (UIView*)timePickerViewForCell
{
    if (_timePickerView==nil) {
        //周期(以天为单位) 可选择:1天，2天，3天，1周，2周，1个月
        _timeArray = [[NSArray alloc]initWithObjects:@"1天",@"2天",@"3天",@"1周",@"2周",@"1个月", nil];
        
        _timePickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, -KTableCellHeight+10, SCREEN_WIDTH, KTableCellHeight)];
        _timePickerView.dataSource = self;
        _timePickerView.delegate = self;
        _timePickerView.showsSelectionIndicator = YES;
    }
    _timePickerView.hidden = NO;
    
    return _timePickerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
        if (indexPath.row==0) {  //持续时间
            if (!_isShowDurationPicker) {
                //显示_durationPickerView
                _isShowDurationPicker = YES;
//                if (_isShowCyclePicker) {
//                    _isShowCyclePicker=NO;
//                    [_tableView reloadData];
//                }
//                if (_isShowTimePicker) {
//                    _isShowTimePicker=NO;
//                    [_tableView reloadData];
//                }
//                [_tableView reloadData];
                [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:nextIndexPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
            }else{
                //隐藏_durationPickerView
                _isShowDurationPicker = !_isShowDurationPicker;
//                [_tableView reloadData];
                [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:nextIndexPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
            }
        }
        
        else if(indexPath.row==1){  //周期
            if (!_isShowCyclePicker) {
                _isShowDurationPicker = NO;
                _isShowCyclePicker = YES;
                _isShowTimePicker = NO;
                [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:nextIndexPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
            }else{
                _isShowCyclePicker = !_isShowCyclePicker;
                [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:nextIndexPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
            }
        }
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
    if (pickerView==_startPickerView||pickerView==_endPickerView) {
        return 2;
    }
    return 1;
}
//确定picker的每个轮子的item数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_durationArray count];
}
//确定每个轮子的每一项显示什么内容
#pragma mark 实现协议UIPickerViewDelegate方法
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_durationArray objectAtIndex:row];
}
@end
