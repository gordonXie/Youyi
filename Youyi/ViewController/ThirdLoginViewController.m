//
//  ThirdLoginViewController.m
//  Youyi
//
//  Created by xieguocheng on 14-11-26.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "ThirdLoginViewController.h"

@interface ThirdLoginViewController ()

@end

@implementation ThirdLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initViews
{
    [super initViews];
    [self setTitle:@"登录"];
    [self addBackBtn];
    
    [self addThirdLogin];
    [self addUseGuide];
}

- (void)addThirdLogin
{
    float startH = 80.0;
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, startH, SCREEN_WIDTH, 20)];
    titleLbl.text = @"请选择登录账号";
    titleLbl.font = [UIFont systemFontOfSize:KCellFontSizeSmall];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor grayColor];
    [self.view addSubview:titleLbl];
    startH += 50.0;
    
    //QQ
    const float btnSize = 50.0;
    UIButton *qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [qqBtn setFrame:CGRectMake((SCREEN_WIDTH-btnSize*2)/3.0, startH, btnSize, btnSize)];
    [qqBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [qqBtn addTarget:self action:@selector(onQQBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqBtn];
    
    UILabel *qqLbl = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-btnSize*2)/3.0,startH+btnSize,btnSize,40)];
    qqLbl.text = @"QQ";
    qqLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:qqLbl];
    
    UIButton *weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [weiboBtn setFrame:CGRectMake((SCREEN_WIDTH-btnSize*2)/3.0*2+btnSize, startH, btnSize, btnSize)];
    [weiboBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [weiboBtn addTarget:self action:@selector(onWeiboBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weiboBtn];
    
    UILabel *weiboLbl = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-btnSize*2)/3.0*2+btnSize-20,startH+btnSize,btnSize+40,40)];
    weiboLbl.text = @"新浪微博";
    weiboLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:weiboLbl];
    
    
}

- (void)onQQBtnClick:(id)sender
{
    
}

- (void)onWeiboBtnClick:(id)sender
{
    
}

//使用手册
- (void)addUseGuide
{
    float height = SCREEN_HEIGHT - 100.0;
    UILabel *guideLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 30.0)];
    guideLbl.textAlignment = NSTextAlignmentCenter;
    guideLbl.text = @"使 用 手 册";
    guideLbl.textColor = [UIColor yellowColor];
    [guideLbl setUserInteractionEnabled:YES];
    [self.view addSubview:guideLbl];
    
    //添加单击手势
    UITapGestureRecognizer *singleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(guideTap)];
    singleGesture.numberOfTapsRequired = 1;
    singleGesture.numberOfTouchesRequired = 1;
    singleGesture.delegate = self;
    [guideLbl addGestureRecognizer:singleGesture];
    
    UILabel *sloganLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, height+40, SCREEN_WIDTH, 50)];
    sloganLbl.text = @"有 意 就 一 起 来 !";
    sloganLbl.font = [UIFont systemFontOfSize:KFontSizeBig];
    sloganLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:sloganLbl];
}

- (void)guideTap
{
    //显示使用手册
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
