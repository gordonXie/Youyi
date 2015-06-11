//
//  HomeViewController.m
//  Youyi
//
//  Created by xieguocheng on 14-11-5.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "HomeViewController.h"
#import "PurposeCreateViewController.h"
#import "SwiftModule-swift.h"
#import "JModel_Purpose.h"
#import "ThirdLoginViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDK/ISSContent.h>
#import <ShareSDK/ISSContainer.h>
#import "JView_Navi.h"
#import "JDataManager.h"

#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "Color.h"


@interface HomeViewController ()<PPItemViewDelegate,JView_NaviDelegate,UIScrollViewDelegate>
{
    UIScrollView    *_baseScrollView;
    NSMutableArray  *_purposeArray;
    JView_Navi      *_naviView;
    
    CalendarHomeViewController *chvc;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initViews
{
    [super initViews];
    [self setTitle:@"新建意向"];
    [self addLeftBtn:@"我的"];
    [self addRightBtn:@"新建"];
    
    [self addBaseScrollView];
}

- (void)addBaseScrollView
{
    _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _baseScrollView.backgroundColor = COLOR_WHITE;
    _baseScrollView.pagingEnabled = YES;
    _baseScrollView.delegate = self;
    [self.view addSubview:_baseScrollView];
    
    [self initPurposeArray];
    //添加"意向"
    [self addPurposes];
}
- (void)initPurposeArray
{
    _purposeArray = [[NSMutableArray alloc]initWithCapacity:5];
    [_purposeArray addObject:@"学习"];
    [_purposeArray addObject:@"塑身"];
    [_purposeArray addObject:@"存钱"];
    [_purposeArray addObject:@"新建"];
    
    JDATAMGR.ppArray = _purposeArray;
    
}
- (void)addPurposes
{
    [self addNaviView];
    
    for(int i=0;i<JDATAMGR.ppArray.count;i++){
        if (i==JDATAMGR.ppArray.count-1) {
            //新建
            PurposeItemView *ppItemView = [[PurposeItemView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, CONTENT_HEIGHT)];
            ppItemView.isNewItem = YES;
            ppItemView.itemDelegate = self;
            ppItemView.backgroundColor = COLOR_BACKGROUND;
            [_baseScrollView addSubview:ppItemView];
            
            _baseScrollView.contentSize = CGSizeMake((i+1)*SCREEN_WIDTH, CONTENT_HEIGHT);
        }else{
            PurposeItemView *ppItemView = [[PurposeItemView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, CONTENT_HEIGHT)];
            ppItemView.itemDelegate = self;
            ppItemView.backgroundColor = COLOR_BACKGROUND;
            JModel_Purpose *pp = [[JModel_Purpose alloc]init];
            pp.ppId = 321;
            pp.name = @"测试";
            pp.style = @"过";
            
            pp.memberArray = [[NSMutableArray alloc]initWithCapacity:3];
            for (int i = 0; i<1; i++) {
                JModel_Member *member = [[JModel_Member alloc]init];
                member.mId = 322;
                member.name = @"腾";
                [pp.memberArray addObject:member];
            }
            ppItemView.ppItem = pp;
            
            [_baseScrollView addSubview:ppItemView];
        }
    }
}

- (void)addNaviView
{
    if (!_naviView) {
        _naviView = [[JView_Navi alloc]init];
        _naviView.frame = CGRectMake(0, NAVBAR_HEIGHT+10, SCREEN_WIDTH, 5);
        _naviView.delegate = self;
        _naviView.sum = JDATAMGR.ppArray.count;
        
        [self.view addSubview:_naviView];
    }
}

#pragma mark - 添加意向
- (void)addNewPurpose
{
    
}

- (void)onLeftBtnClick:(id)sender
{
//    UserCenterViewController *userVC = [[UserCenterViewController alloc]init];
//    [appDelegate.navController pushViewController:userVC animated:YES];
    if (![[XCommon UserDefaultGetValueFromKey:ISLOGINKEY] isEqualToString:@"1"]) { //已登录
        UserCenterVC *userVC = [[UserCenterVC alloc]init];
        [appDelegate.navController pushViewController:userVC animated:YES];
    }else{
        ThirdLoginViewController *thirdLoginVC = [[ThirdLoginViewController alloc]init];
        [appDelegate.navController pushViewController:thirdLoginVC animated:YES];
    }

}

- (void)onRightBtnClick:(id)sender
{
    PurposeCreateViewController *purposeCreateVC = [[PurposeCreateViewController alloc]init];
    [appDelegate.navController pushViewController:purposeCreateVC animated:YES];
}

- (void)onNewBtnClick
{
    PurposeCreateViewController *purposeCreateVC = [[PurposeCreateViewController alloc]init];
    [appDelegate.navController pushViewController:purposeCreateVC animated:YES];
}

#pragma mark -PPItemViewDelegate
- (void)onActionBtnClick
{
    
}

- (void)onActionBtnLongPress
{
    
}

- (void)onMemberBtnClick:(NSInteger)index
{
    NSLog(@"member %ld",index);
}

- (void)onRecordBtnClick
{
    if (!chvc) {
        
        chvc = [[CalendarHomeViewController alloc]init];
        
        chvc.calendartitle = @"飞机";
        
//        [chvc setAirPlaneToDay:365 ToDateforString:nil];//飞机初始化方法
        [chvc setRecordFromDate:@"2014-11-10" withDuration:80 withCycle:7];
        
    }
    
    chvc.calendarblock = ^(CalendarDayModel *model){
        
        NSLog(@"\n---------------------------");
        NSLog(@"1星期 %@",[model getWeek]);
        NSLog(@"2字符串 %@",[model toString]);
        NSLog(@"3节日  %@",model.holiday);
        
//        if (model.holiday) {
//            
//            [but setTitle:[NSString stringWithFormat:@"%@ %@ %@",[model toString],[model getWeek],model.holiday] forState:UIControlStateNormal];
//            
//        }else{
//            
//            [but setTitle:[NSString stringWithFormat:@"%@ %@",[model toString],[model getWeek]] forState:UIControlStateNormal];
//            
//        }
    };
    
    [self.navigationController pushViewController:chvc animated:YES];
    
}

- (void)onShareBtnClick
{
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    //[ShareSDK imageWithPath:imagePath]
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"WeChat"
                                       defaultContent:@"hahahaha"
                                                image:[ShareSDK pngImageWithImage:[UIImage imageNamed:@"share"]]
                                                title:@"有意就一起来."
                                                  url:@""
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:self.view arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger index = scrollView.contentOffset.x/SCREEN_WIDTH;
    [_naviView setSelectedIndex:index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
