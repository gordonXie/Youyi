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
#import "OHAlertView.h"

#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "Color.h"

#define KBasePPItemViewTag 200

@interface HomeViewController ()<PPItemViewDelegate,UIScrollViewDelegate>
{
    UIScrollView    *_baseScrollView;
    JView_Navi      *_naviView;
    NSUInteger      _currentIndex;
    BOOL            _isJoin;
    
    CalendarHomeViewController *chvc;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)initViews
{
    [super initViews];
    [self setTitle:@"新建意向"];
    [self addLeftBtn:@"我的"];
    [self addRightBtn:@"新建"];
    
    _currentIndex = 0;
    _isJoin = YES;
    [self addNotification];
    [self addBaseScrollView];
}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiAddPurpose) name:NOTIFICATION_PP_ADD object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPurposeList) name:NOTIFICATION_PP_REFRESH object:nil];
}

- (void)addBaseScrollView
{
    _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _baseScrollView.backgroundColor = COLOR_WHITE;
    _baseScrollView.pagingEnabled = YES;
    _baseScrollView.delegate = self;
    [self.view addSubview:_baseScrollView];
    
//    [self initPurposeArray];
    [self setNaviView];
    //添加"意向"
    [self addPurposes];
}
- (void)initPurposeArray
{
    JDATAMGR.ppArray = [NSMutableArray array];
    
}
- (void)addPurposes
{
    _baseScrollView.contentSize = CGSizeMake(JDATAMGR.ppArray.count*SCREEN_WIDTH, CONTENT_HEIGHT);
    for(int i=0;i<JDATAMGR.ppArray.count;i++){
//        if (i==JDATAMGR.ppArray.count-1) {
//            //新建
//            PurposeItemView *ppItemView = [[PurposeItemView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, CONTENT_HEIGHT)];
//            ppItemView.isNewItem = YES;
//            ppItemView.itemDelegate = self;
//            ppItemView.backgroundColor = COLOR_BACKGROUND;
//            [_baseScrollView addSubview:ppItemView];
//            
//            
//        }else
        {
            PurposeItemView *ppItemView = [[PurposeItemView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, CONTENT_HEIGHT)];
            ppItemView.itemDelegate = self;
            ppItemView.backgroundColor = COLOR_BACKGROUND;
            ppItemView.tag = i+KBasePPItemViewTag;
            JModel_Purpose *pp = [[JModel_Purpose alloc]init];
            pp.ppId = 321;
            pp.name = @"测试";
            pp.actionVerb = @"过";
            
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

- (void)setNaviView
{
    if (!_naviView) {
        _naviView = [[JView_Navi alloc]init];
        _naviView.frame = CGRectMake(0, NAVBAR_HEIGHT+10, SCREEN_WIDTH, 5);
        _naviView.sum = JDATAMGR.ppArray.count;
        
        [self.view addSubview:_naviView];
    }else{
        _naviView.sum = JDATAMGR.ppArray.count;
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
    __weak typeof(self) weakSelf = self;
    if (_isJoin) {
        [OHAlertView showAlertWithTitle:@"提示" message:@"你确定要加入该意向吗？" cancelButton:@"取消" okButton:@"确定" buttonHandler:^(OHAlertView *alert, NSInteger buttonIndex) {
            if (buttonIndex!=0) {
                [weakSelf joinPurpose];
            }
        }];
    }else{
        [OHAlertView showAlertWithTitle:@"提示" message:@"你确定要退出该意向吗？" cancelButton:@"取消" okButton:@"确定" buttonHandler:^(OHAlertView *alert, NSInteger buttonIndex) {
            if (buttonIndex!=0) {
                [weakSelf quitPurpose];
            }
        }];
    }

}
//加入意向
- (void)joinPurpose
{
    JModel_Purpose *purpose = [JDATAMGR.ppArray objectAtIndex:_currentIndex];

    JModel_Member *member = [JModel_Member objectWithDictionary:[NSMutableDictionary dictionary]];
    [purpose.memberArray addObject:member];
    
    PurposeItemView *ppItemView = (PurposeItemView*)[_baseScrollView viewWithTag:_currentIndex+KBasePPItemViewTag];
    ppItemView.ppItem = purpose;
    
    if(purpose.memberArray.count>=8)
    {
        _isJoin = NO;
    }
}

//退出意向
- (void)quitPurpose
{
    JModel_Purpose *purpose = [JDATAMGR.ppArray objectAtIndex:_currentIndex];
    
    [purpose.memberArray removeObjectAtIndex:purpose.memberArray.count-1];
    
    PurposeItemView *ppItemView = (PurposeItemView*)[_baseScrollView viewWithTag:_currentIndex+KBasePPItemViewTag];
    ppItemView.ppItem = purpose;
    
    if(purpose.memberArray.count<=1){
        _isJoin = YES;
    }
}

- (void)onMemberBtnClick:(NSInteger)index
{
    NSLog(@"member %ld",(long)index);
}

- (void)onRecordBtnClick
{
    PurposeCreateViewController *ppCreateVC = [[PurposeCreateViewController alloc]init];
    JModel_Purpose *purpose = [JDATAMGR.ppArray objectAtIndex:_currentIndex];
    ppCreateVC.purpose = purpose;
    [appDelegate.navController pushViewController:ppCreateVC animated:YES];
    
    /*
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
*/
    
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
    _currentIndex = scrollView.contentOffset.x/SCREEN_WIDTH;
    [_naviView setSelectedIndex:_currentIndex];
    self.title = ((JModel_Purpose*)[JDATAMGR.ppArray objectAtIndex:_currentIndex]).name;
}

#pragma mark - NotificationCenter
- (void)notiAddPurpose
{
    const NSUInteger count = JDATAMGR.ppArray.count;
    PurposeItemView *ppItemView = [[PurposeItemView alloc]initWithFrame:CGRectMake((count-1)*SCREEN_WIDTH, 0, SCREEN_WIDTH, CONTENT_HEIGHT)];
    ppItemView.itemDelegate = self;
    ppItemView.backgroundColor = COLOR_BACKGROUND;
    ppItemView.ppItem = [JDATAMGR.ppArray objectAtIndex:count-1];
    ppItemView.tag = KBasePPItemViewTag+count-1;
    
    [_baseScrollView addSubview:ppItemView];
    _baseScrollView.contentSize = CGSizeMake(count*SCREEN_WIDTH, CONTENT_HEIGHT);
    [_baseScrollView setContentOffset:CGPointMake((count-1)*SCREEN_WIDTH, SCREEN_HEIGHT) animated:YES];

    _currentIndex = count-1;
    [self setNaviView];
    [_naviView setSelectedIndex:_currentIndex];
    self.title = ((JModel_Purpose*)[JDATAMGR.ppArray objectAtIndex:_currentIndex]).name;
    [_baseScrollView sizeToFit];
}
- (void)refreshPurposeList
{
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
