//
//  CalendarHomeViewController.m
//  Calendar
//
//  Created by 张凡 on 14-6-23.
//  Copyright (c) 2014年 张凡. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "CalendarHomeViewController.h"
#import "Color.h"

@interface CalendarHomeViewController ()
{

    
    int daynumber;//天数
    int optiondaynumber;//选择日期数量
//    NSMutableArray *optiondayarray;//存放选择好的日期对象数组
    
}

@end

@implementation CalendarHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 设置方法

//飞机初始化方法
- (void)setAirPlaneToDay:(int)day ToDateforString:(NSString *)todate
{
    daynumber = day;
    optiondaynumber = 1;//选择一个后返回数据对象
    super.calendarMonth = [self getMonthArrayOfDayNumber:daynumber ToDateforString:todate];
    [super.collectionView reloadData];//刷新
}

//酒店初始化方法
- (void)setHotelToDay:(int)day ToDateforString:(NSString *)todate
{

    daynumber = day;
    optiondaynumber = 2;//选择两个后返回数据对象
    super.calendarMonth = [self getMonthArrayOfDayNumber:daynumber ToDateforString:todate];
    [super.collectionView reloadData];//刷新
}


//火车初始化方法
- (void)setTrainToDay:(int)day ToDateforString:(NSString *)todate
{
    daynumber = day;
    optiondaynumber = 1;//选择一个后返回数据对象
    super.calendarMonth = [self getMonthArrayOfDayNumber:daynumber ToDateforString:todate];
    [super.collectionView reloadData];//刷新
    
}
//记录初始化方法
- (void)setRecordFromDate:(NSString*)fromDate withDuration:(int)durDays withCycle:(int)cycDays
{
    daynumber = durDays;
    optiondaynumber = 1;
    super.CalendarMonth = [self getMonthArrayOfDuration:durDays withCycle:cycDays fromDateforString:fromDate];
    [super.collectionView reloadData];
}

#pragma mark - 逻辑代码初始化

//获取时间段内的天数数组
- (NSMutableArray *)getMonthArrayOfDayNumber:(int)day ToDateforString:(NSString *)todate
{
    
    NSDate *date = [NSDate date];
    
    NSDate *selectdate  = [NSDate date];
    
    if (todate) {
        
        selectdate = [selectdate dateFromString:todate];
        
    }
    
    super.Logic = [[CalendarLogic alloc]init];
    
    return [super.Logic reloadCalendarView:date selectDate:selectdate  needDays:day];
}

- (NSMutableArray *)getMonthArrayOfDuration:(int)durDays withCycle:(int)cycDays fromDateforString:(NSString *)fromDate
{
    
    NSDate *date = [NSDate date];
    if (fromDate) {
        date = [date dateFromString:fromDate];
    }
    
    NSDate *selectdate  = [NSDate date];
    
//    if (todate) {
//        
//        selectdate = [selectdate dateFromString:todate];
//        
//    }
    
    super.Logic = [[CalendarLogic alloc]init];
    
    return [super.Logic reloadCalendarView:date selectDate:selectdate  needDays:durDays];
}

//#pragma mark - 设置标题
//
//- (void)setCalendartitle:(NSString *)calendartitle
//{
//
//    [self.navigationItem setTitle:calendartitle];
//
//}


@end
