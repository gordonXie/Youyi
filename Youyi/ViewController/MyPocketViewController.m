//
//  MyPocketViewController.m
//  CustomAPP
//
//  Created by xieguocheng on 14-9-11.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "MyPocketViewController.h"

const float KCellHeight = 81.0;
const float KManagerHeight = 50.0;

@interface MyPocketViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_tableArray;
    BOOL _isEditing;
    NSMutableArray *_delIDArray;
    NSMutableArray *_delIndexArray;
    
    BOOL _isAllSelected;
}
@end

@implementation MyPocketViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isEditing = NO;
        _isAllSelected = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"我的口袋";
    [self addBackBtn];
//    [self addRightBtnWithImg:[UIImage imageNamed:[NSString stringWithFormat:@"%@_pocket_del_normal@2x",appDelegate.configInfo.colorType]] selectImg:[UIImage imageNamed:@"red_pocket_del_sel@2x"]];
    
//    _tableArray = [NSMutableArray arrayWithObjects:@"",@"",@"",nil,nil, nil];
//    [self requestMyCoupons];
    [self  addTableView];
}

- (void)onRightBtnClick:(id)sender
{
    
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addTableView
{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, CONTENT_HEIGHT)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tableArray.count==0) {
        if ([self getRightBtn]!=nil) {
            [self getRightBtn].hidden = YES;
        }
    }else{
        if ([self getRightBtn]!=nil) {
            [self getRightBtn].hidden = NO;
        }
        [self removeNoDataView];
    }
    
    return _tableArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strIdentify = @"identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentify];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        const float space = 4.0;
        const float imgWidth = 80.0;
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(space, space, imgWidth, KCellHeight-space*2)];
        imgView.tag = 101;
        [cell.contentView addSubview:imgView];
        
        const float textCellHeight = KCellHeight/3.0;
        
        UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(imgWidth+space*2, 0, SCREEN_WIDTH-imgWidth-space*3, textCellHeight)];
        titleLbl.tag = 102;
        [cell.contentView addSubview:titleLbl];
        
        const float rightTextWidth = 100.0;
        UILabel *serialNumLbl = [[UILabel alloc]initWithFrame:CGRectMake(imgWidth+space*2, textCellHeight, SCREEN_WIDTH-imgWidth-space*2-rightTextWidth, textCellHeight)];
        serialNumLbl.tag = 103;
        serialNumLbl.font = [UIFont systemFontOfSize:13.0];
        [cell.contentView addSubview:serialNumLbl];
        
        UILabel *moneyLbl = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-rightTextWidth, textCellHeight, rightTextWidth-space, textCellHeight)];
        moneyLbl.tag = 104;
        moneyLbl.font = [UIFont systemFontOfSize:20.0];
        [cell.contentView addSubview:moneyLbl];
        
        UILabel *dateLbl = [[UILabel alloc]initWithFrame:CGRectMake(imgWidth+space*2, textCellHeight*2, SCREEN_WIDTH-imgWidth-space*2-rightTextWidth, textCellHeight)];
        dateLbl.tag = 105;
        dateLbl.font = [UIFont systemFontOfSize:13.0];
        dateLbl.textColor = [XCommon hexStringToColor:@"#696969"];
        [cell.contentView addSubview:dateLbl];
        
        UILabel *stateLbl = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-rightTextWidth, textCellHeight*2, rightTextWidth-space, textCellHeight)];
        stateLbl.tag = 106;
        stateLbl.text = @"已使用";
        stateLbl.font = [UIFont systemFontOfSize:20.0];
        [cell.contentView addSubview:stateLbl];
        
        const float btnSize = 36.0;
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.frame = CGRectMake(SCREEN_WIDTH-btnSize-5, (KCellHeight-btnSize)/2.0, btnSize, btnSize);
        [selectBtn setImage:[UIImage imageNamed:@"red_pocket_sel_normal@2x"] forState:UIControlStateNormal];
        [selectBtn addTarget:self action:@selector(onSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        selectBtn.tag = 107;
        [cell.contentView addSubview:selectBtn];
        
        UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, KCellHeight-1, SCREEN_WIDTH, 1)];
        [lineView setImage:[UIImage imageNamed:@"red_tableView_line@2x"]];
        [cell.contentView addSubview:lineView];
    }
    
    UIImageView *imgView = (UIImageView*)[cell.contentView viewWithTag:101];
    UILabel *titleLbl = (UILabel*)[cell.contentView viewWithTag:102];
    UILabel *numLbl = (UILabel*)[cell.contentView viewWithTag:103];
    UILabel *moneyLbl = (UILabel*)[cell.contentView viewWithTag:104];
    UILabel *dateLbl = (UILabel*)[cell.contentView viewWithTag:105];
    UILabel *stateLbl = (UILabel*)[cell.contentView viewWithTag:106];
 
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
- (void)onSelectBtnClick:(id)sender
{


}


@end
