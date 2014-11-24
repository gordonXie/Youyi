//
//  UserCenterViewController.m
//  CustomAPP
//
//  Created by xieguocheng on 14-9-4.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "UserCenterViewController.h"
#import "LoginViewController.h"
#import "ModifyPwdViewController.h"
#import "MyPocketViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "ContactUsViewController.h"

const float kTableCellHeight = 50.0;
const float kTableViewHeight = 370.0;

@interface UserCenterViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
{
    UIScrollView *_scrollView;
    UITableView *_tableView;
}

@end

@implementation UserCenterViewController

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

    self.titleLabel.text = @"个人中心";
    [self addBackBtn];
    
    [self addTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_tableView) {
        [_tableView reloadData];
    }
    if ([[XCommon UserDefaultGetValueFromKey:ISLOGINKEY] isEqualToString:@"1"]) {
        [self addLogoutBtn];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addTableView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, CONTENT_HEIGHT)];
    [self.view addSubview:_scrollView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, kTableViewHeight)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tag = 99;
    _tableView.scrollEnabled = NO;
    [_scrollView addSubview:_tableView];
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, kTableViewHeight);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 4;
            break;
        default:
            break;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strIdentify = @"identify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentify];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strIdentify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        const float fontSize = 16.0;
        cell.textLabel.font = [UIFont systemFontOfSize:fontSize];
        
        UIImageView *bgView = [[UIImageView alloc]initWithFrame:cell.frame];
        [bgView setImage:[UIImage imageNamed:@"table_up@2x"]];
        bgView.tag = 101;
        [cell setBackgroundView:bgView];
        if (indexPath.row==0) {
            CGRect lineRect = CGRectOffset(bgView.frame, 0, kTableCellHeight-1);
            lineRect.size.height = 1;
            UIImageView *lineView = [[UIImageView alloc]initWithFrame:lineRect];
            [lineView setImage:[UIImage imageNamed:@"table_line@2x"]];
            [cell addSubview:lineView];
        }else{
            [bgView setImage:[UIImage imageNamed:@"table_down@2x"]];
            //            bgView.frame = CGRectOffset(bgView.frame, 0, 0);
        }
        
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                cell.textLabel.text = @"我的账号";
                
                UILabel *nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-260, 0, 200, kTableCellHeight)];
                nameLbl.tag = 110;

                nameLbl.backgroundColor = [UIColor clearColor];
                nameLbl.textAlignment = NSTextAlignmentRight;
                nameLbl.textColor = [XCommon hexStringToColor:@"#bebebe"];
                nameLbl.font = [UIFont systemFontOfSize:fontSize];
                [cell.contentView addSubview:nameLbl];
                
                
            }else if(indexPath.row==1){
                cell.textLabel.text = @"我的口袋";
                
                UILabel *couponLbl = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-260, 0, 200, kTableCellHeight)];
                couponLbl.tag = 111;
                couponLbl.text = @"优惠券  3";
                couponLbl.backgroundColor = [UIColor clearColor];
                couponLbl.textAlignment = NSTextAlignmentRight;
                couponLbl.textColor = [XCommon hexStringToColor:@"#bebebe"];
                couponLbl.font = [UIFont systemFontOfSize:fontSize];
                [cell.contentView addSubview:couponLbl];
            }
        }else if(indexPath.section==1){
            if (indexPath.row==0) {
                cell.textLabel.text = @"密码修改";
            }else if(indexPath.row==1){
                cell.textLabel.text = @"清除缓存";
                
                UILabel *sizeLbl = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-180, (kTableCellHeight-20)/2.0, 120, 20)];
                sizeLbl.textAlignment = NSTextAlignmentRight;
                sizeLbl.backgroundColor = [UIColor clearColor];
                sizeLbl.textColor = [XCommon hexStringToColor:@"#bebebe"];
                sizeLbl.tag = 100;
                sizeLbl.font = [UIFont systemFontOfSize:fontSize];
                [cell.contentView addSubview:sizeLbl];
            }else if (indexPath.row==2) {
                cell.textLabel.text = @"分享好友";
            }
            else if (indexPath.row==3){
                cell.textLabel.text = @"联系我们";
            }
            
        }
    }
    
    if (indexPath.section == 0) {
        UILabel *nameLbl = (UILabel*)[cell.contentView viewWithTag:110];
        UILabel *couponLbl = (UILabel*)[cell.contentView viewWithTag:111];
        if (indexPath.row==0) {
            if ([[XCommon UserDefaultGetValueFromKey:ISLOGINKEY] isEqualToString:@"1"]) {
                nameLbl.text = [XCommon UserDefaultGetValueFromKey:NIKENAME];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }else{
                nameLbl.text = @"未登录";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }else if(indexPath.row==1){
            if ([[XCommon UserDefaultGetValueFromKey:ISLOGINKEY] isEqualToString:@"1"]) {
                couponLbl.text = @"优惠券";
            }else{
                couponLbl.text = @"未登录";
            }
        }
    }

    if (indexPath.section==1) {
        UILabel *sizeLbl = (UILabel*)[cell.contentView viewWithTag:100];
        sizeLbl.text = [self sizeOfCache];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];
    switch (section) {
        case 0:
            break;
        case 1:
        {
            UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
            lbl.text = @"其他";
            lbl.backgroundColor = [UIColor clearColor];
            [headView addSubview:lbl];
            break;
        }
        default:
            break;
    }
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kTableCellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 10;
            break;
        case 1:
            return 40;
            break;
        default:
            break;
    }
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            if (![[XCommon UserDefaultGetValueFromKey:ISLOGINKEY] isEqualToString:@"1"]) {
                //登录
                LoginViewController *loginVC = [[LoginViewController alloc]init];
                [appDelegate.navController pushViewController:loginVC animated:YES];
            }
        }else if(indexPath.row==1){
            if ([[XCommon UserDefaultGetValueFromKey:ISLOGINKEY] isEqualToString:@"1"]) {
                MyPocketViewController *pocketVC = [[MyPocketViewController alloc]init];
                [appDelegate.navController pushViewController:pocketVC animated:YES];
            }else{
                //登录
                LoginViewController *loginVC = [[LoginViewController alloc]init];
                [appDelegate.navController pushViewController:loginVC animated:YES];
            }
        }

    }else if(indexPath.section==1){
        if (indexPath.row==0) {
            if ([[XCommon UserDefaultGetValueFromKey:ISLOGINKEY] isEqualToString:@"1"]) {
                //@"修改密码";
                ModifyPwdViewController *modifyVC = [[ModifyPwdViewController alloc]init];
                [appDelegate.navController pushViewController:modifyVC animated:YES];
            }else{
                LoginViewController *loginVC = [[LoginViewController alloc]init];
               [appDelegate.navController pushViewController:loginVC animated:YES];
            }
        }else if (indexPath.row==1) {
            //@"清除缓存";
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"是否清除缓存？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"清除缓存", nil];
            [alertView show];
        }else if (indexPath.row == 2){
            //分享
            [self chooseShareType];
        }else{
            //联系我们
            [self contactUs];
        }
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {  //取消
        return;
    }else{
        [self removeCache];
    }
}

- (void)addLogoutBtn
{
    UIButton *logoutBtn = (UIButton*)[_scrollView viewWithTag:98];
    if (logoutBtn==nil) {
        float btnWidth = SCREEN_WIDTH-20;
        logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        logoutBtn.tag = 98;
        [logoutBtn setFrame:CGRectMake((SCREEN_WIDTH-btnWidth)/2.0, kTableViewHeight, btnWidth, 40)];
        [logoutBtn setBackgroundImage:[UIImage imageNamed:@"logout_bg_normal@2x"] forState:UIControlStateNormal];
        [logoutBtn setBackgroundImage:[UIImage imageNamed:@"logout_bg_select@2x"] forState:UIControlStateHighlighted];
        [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        logoutBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [logoutBtn addTarget:self action:@selector(onLogoutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:logoutBtn];
        
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, kTableViewHeight+40);
    }
}

- (void)onLogoutBtnClick:(id)sender
{
    [self requestLogout];
}

- (void)requestLogout
{
    /*
    if (![AFNetworkReachability checkNetworkConnectivity]) {
        [self.view makeToast:KNetwork_NotReachable];
        return;
    }
    
    NSURL *baseURL = [NSURL URLWithString:Base_URL];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:appDelegate.configInfo.bossId forKey:@"bossId"];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    client.parameterEncoding = AFFormURLParameterEncoding;
    [self hudShowWithLabel:@"正在注销..."];
    [client postPath:@"logout"
          parameters:dic
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 [self hudHidden];
                 NSError *error;
                 NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingAllowFragments error:&error];
                 if (dic==nil) {  //json解析失败
                     [XCommon showAlertWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"%@",error]];
                 }else if (IS_NETREQUEST_SUCCESS([dic objectForKey:@"state"])) {
//                     [self.view makeToast:[dic objectForKey:@"msg"]];
                     [self.view makeToast:@"注销成功"];

                     [XCommon UserDefaultSetValue:@"0" forKey:ISLOGINKEY];
                     [XCommon UserDefaultSetValue:@"" forKey:SESSIONID];
                     
                     [self removeLogoutBtn];
                 }else{
                     [self.view makeToast:@"注销成功"];
                     
                     [XCommon UserDefaultSetValue:@"0" forKey:ISLOGINKEY];
                     [XCommon UserDefaultSetValue:@"" forKey:SESSIONID];
                     [self removeLogoutBtn];
                 }
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 [self netFailureWithError:error];
             }
     ];
     */
}


- (NSString *)sizeOfCache
{
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [[cachePaths objectAtIndex:0] stringByAppendingPathComponent:@"ImageCache"];
    return [NSString stringWithFormat:@"%.1lf MB",[XCommon fileSizeForDir:cachePath]/1024.0/1024.0];
}

- (void)removeCache
{
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [[cachePaths objectAtIndex:0] stringByAppendingPathComponent:@"ImageCache"];
    if ([XCommon fileSizeForDir:cachePath]==0) {
        [self.view makeToast:@"暂无缓存"];
        return;
    }
    [self hudShowWithLabel:@"正在清除缓存..."];
    
    BOOL isSuccess = [XCommon deleteDirInCache:cachePath];
//    [self clearDBTable];
    [self hudHidden];
    if (isSuccess) {
        [self.view makeToast:@"缓存已清空"];
        
        UITableView *tableView = (UITableView*)[_scrollView viewWithTag:99];
        [tableView reloadData];
    }else{
        [self.view makeToast:@"缓存清除失败"];
    }
}

- (void)removeLogoutBtn
{
    [_tableView reloadData];
    UIButton *logoutBtn = (UIButton*)[_scrollView viewWithTag:98];
    if (logoutBtn!=nil) {
        logoutBtn.hidden = YES;
        [logoutBtn removeFromSuperview];
        logoutBtn = nil;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, kTableViewHeight);
    }
}

#pragma mark - 选择分享类型
- (void)chooseShareType
{
    UIActionSheet * actionSheet;
//    if (IOS7ANDLATER) {
//        actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"新浪微博" otherButtonTitles:@"腾讯微博", nil];
//    }else
    
    {
        actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"新浪微博" otherButtonTitles:nil, nil];
    }

    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        //新浪微博
        [self getShareAccount:ACAccountTypeIdentifierSinaWeibo];
    }
    
//    else if (buttonIndex==1){
//        //腾讯微博
//        [self getShareAccount:ACAccountTypeIdentifierTencentWeibo];
//    }
}

#pragma mark - share
- (void)getShareAccount:(NSString*)weiboType
{
    ACAccountStore *accountStore = [[ACAccountStore alloc]init];
    //指定账号类型
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:weiboType];
    //options:nil 腾讯微博 引起错误
//    NSDictionary *appDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"ACTencentWeiboAppIdKey",@"801550662", nil];
//    NSDictionary *appDic = [[NSDictionary alloc]init];
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        if (granted) {
            //获取账号列表
            NSArray *accountArray = [accountStore accountsWithAccountType:accountType];
            if (accountArray.count>0) {
                ACAccount *account = accountArray[0];
                NSLog(@"账号信息：%@",account);
                if ([weiboType isEqualToString:ACAccountTypeIdentifierSinaWeibo]) {
                    [self requestSinaWeiboWithAccount:account];
                }else if([weiboType isEqualToString:ACAccountTypeIdentifierTencentWeibo]){
                    [self requestTencentWeiboWithAccount:account];
                }

            }else{
                NSLog(@"未添加账号");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [XCommon showAlertWithTitle:@"温馨提示" message:@"您尚未设置微博账号，请到设置中去添加"];
                });
            }
        }else{
            NSLog(@"未授权");
            dispatch_async(dispatch_get_main_queue(), ^{
                [XCommon showAlertWithTitle:@"温馨提示" message:@"您尚未设置微博账号，请到设置中去添加"];
            });
        }
    }];
}

- (void)requestSinaWeiboWithAccount:(ACAccount *)account
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithCapacity:2];
    [params setObject:@"我最近使用了大唐英加定制化产品，感觉不错，来试试吧！http://......" forKey:@"status"];
    
    //新浪微博分享接口
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/2/statuses/update.json"];
    SLRequest *request =  [SLRequest requestForServiceType:SLServiceTypeSinaWeibo requestMethod:SLRequestMethodPOST URL:url parameters:params];
    request.account = account;
    
    [self hudShowWithLabel:@"正在分享..."];
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        [self hudHidden];
        //NSLog(@" == %@",responseData);
        NSError *errorr = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&errorr];
        if (!error)
        {
//            [self.view makeToast:@"分享成功"]; //不会显示
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view makeToast:@"分享成功"];
            });
            NSLog(@"结果: %@",dic);
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view makeToast:@"分享失败，请稍后重试"];
            });
        }
    }];
}

- (void)requestTencentWeiboWithAccount:(ACAccount*)account
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithCapacity:2];
    [params setObject:@"今晚吃啥?" forKey:@"status"];
    
    //腾讯微博分享接口
    NSURL *url = [NSURL URLWithString:@"http://open.t.qq.com/api/t/add"];
    SLRequest *request =  [SLRequest requestForServiceType:SLServiceTypeTencentWeibo requestMethod:SLRequestMethodPOST URL:url parameters:params];
    request.account = account;
    
    [self hudShowWithLabel:@"正在分享..."];
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        [self hudHidden];
        NSError *errorr = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&errorr];
        if (!error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view makeToast:@"分享成功"];
            });
            NSLog(@"结果: %@",dic);
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view makeToast:@"分享失败，请稍后重试"];
            });
        }
    }];

}

//联系我们
-(void)contactUs
{
    ContactUsViewController *contactUsVC = [[ContactUsViewController alloc]init];
    [appDelegate.navController pushViewController:contactUsVC animated:YES];
}
@end
