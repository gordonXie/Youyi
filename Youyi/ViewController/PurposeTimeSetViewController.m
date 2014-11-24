//
//  PurposeTimeSetViewController.m
//  Youyi
//
//  Created by xieguocheng on 14-11-11.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "PurposeTimeSetViewController.h"
@interface PurposeTimeSetViewController()<UIPickerViewDelegate>
{
    UIScrollView    *_baseScrollView;
    UIDatePicker    *_startTimePicker;
    UIDatePicker    *_endTimePicker;
}
@end

@implementation PurposeTimeSetViewController
@synthesize startTime;
@synthesize endTime;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initViews
{
    [super initViews];
    [self setTitle:@"时段设置"];
    [self addBackBtn:@"取消"];
    [self addRightBtn:@"保存"];
    
    [self addBaseScrollView];
}

- (void)addBaseScrollView
{
    _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_baseScrollView];
    
    [self addItemViews];
}

- (void)addItemViews
{
    float startH = 10.0;
    const float edge = 10.0;
    UILabel *startLbl = [[UILabel alloc]initWithFrame:CGRectMake(edge, startH, 100, 20)];
    startLbl.text = @"开始时间";
    startLbl.font = [UIFont systemFontOfSize:KFontSizeCommon];
    [_baseScrollView addSubview:startLbl];
    startH += 20;
    
    const float pickerHeight = 50.0;
    _startTimePicker = [[UIDatePicker alloc]init];
    _startTimePicker.frame = CGRectMake(edge, startH, SCREEN_WIDTH/2.0-edge, pickerHeight);
    _startTimePicker.datePickerMode = UIDatePickerModeTime;
    [_baseScrollView addSubview:_startTimePicker];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"]; // 这里是用大写的 H
    NSDate *startDate = [dateFormatter dateFromString:@"06:00"];
    if (![XCommon isNullString:startTime]) {
        startDate = [dateFormatter dateFromString:startTime];
    }
    _startTimePicker.date = startDate;
    [_startTimePicker addTarget:self action:@selector(startTimeChange:)
         forControlEvents:UIControlEventValueChanged];
    startH += pickerHeight*2+80;
    
    UILabel *endLbl = [[UILabel alloc]initWithFrame:CGRectMake(edge, startH, 100, 20)];
    endLbl.text = @"结束时间";
    endLbl.font = [UIFont systemFontOfSize:KFontSizeCommon];
    [_baseScrollView addSubview:endLbl];
    startH += 20;
    
    _endTimePicker = [[UIDatePicker alloc]init];
    _endTimePicker.frame =CGRectMake(edge, startH, SCREEN_WIDTH/2.0-edge, pickerHeight);
    _endTimePicker.datePickerMode = UIDatePickerModeTime;
    [_baseScrollView addSubview:_endTimePicker];
    NSDate *endDate = [dateFormatter dateFromString:@"22:00"];
    if (![XCommon isNullString:endTime]) {
        endDate = [dateFormatter dateFromString:endTime];
    }
    _endTimePicker.date = endDate;
    _endTimePicker.minimumDate = _startTimePicker.date;
    
    [_endTimePicker addTarget:self action:@selector(endTimeChange:)
               forControlEvents:UIControlEventValueChanged];
    startH += pickerHeight+20;
}

- (void)startTimeChange:(id)sender
{
    _endTimePicker.minimumDate = _startTimePicker.date;
}
- (void)endTimeChange:(id)sender
{
    
}
@end
