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

@interface HomeViewController ()<PPItemViewDelegate>
{
    UIScrollView    *_baseScrollView;
    NSMutableArray  *_purposeArray;
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
    [self addRightBtn:@"广场"];
    
    [self addBaseScrollView];
}

- (void)addBaseScrollView
{
    _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _baseScrollView.pagingEnabled = YES;
    [self.view addSubview:_baseScrollView];
    
    [self initPurposeArray];
    //添加"意向"
    [self addPurposes];
}
- (void)initPurposeArray
{
    _purposeArray = [[NSMutableArray alloc]initWithCapacity:5];
    [_purposeArray addObject:@"学习"];
//    [_purposeArray addObject:@"塑身"];
//    [_purposeArray addObject:@"存钱"];
    [_purposeArray addObject:@"新建"];
}
- (void)addPurposes
{
    for(int i=0;i<_purposeArray.count;i++){
        if (i==_purposeArray.count-1) {
            //新建
            PurposeItemView *ppItemView = [[PurposeItemView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, CONTENT_HEIGHT)];
            ppItemView.isNewItem = YES;
            ppItemView.itemDelegate = self;
            [_baseScrollView addSubview:ppItemView];
            
            _baseScrollView.contentSize = CGSizeMake((i+1)*SCREEN_WIDTH, CONTENT_HEIGHT);
        }else{
            PurposeItemView *ppItemView = [[PurposeItemView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, CONTENT_HEIGHT)];
            ppItemView.itemDelegate = self;
            [_baseScrollView addSubview:ppItemView];
        }
    }
}
#pragma mark - 添加意向
- (void)addNewPurpose
{
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
