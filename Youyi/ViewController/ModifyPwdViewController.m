//
//  ModifyPwdViewController.m
//  CustomAPP
//
//  Created by xieguocheng on 14-9-10.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "ModifyPwdViewController.h"

@interface ModifyPwdViewController ()<UITextFieldDelegate>
{
    UIView *_baseView;
    UITextField *_pwdTF;
    UITextField *_newPwdTF;
    UITextField *_reNewPwdTF;
    
    BOOL _isAlreadySlide;
}

@end

@implementation ModifyPwdViewController

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
    [self.view setBackgroundColor:[XCommon hexStringToColor:KUserCenter_Bg_Color]];
    self.titleLabel.text = @"修改密码";
    [self addBackBtn];
    
    [self addSubViews];
}

- (void)addSubViews
{
    _baseView = [[UIView alloc]initWithFrame:CGRectOffset(self.view.frame, 0, NAVBAR_HEIGHT)];
    [_baseView setBackgroundColor:UCBGCOLOR];
    [self.view insertSubview:_baseView atIndex:0];
    
    const float textFontSize = 16.0;
    const float btnFontSize = 18.0;
    float TFWidth  = 300.0;
    float TFHeight = 50.0;
    float itemSpace = 5.0;
    
    CGRect accountRect = CGRectMake((SCREEN_WIDTH-TFWidth)/2.0, 20, TFWidth, TFHeight);
    UITextField *accountTF = [[UITextField alloc]initWithFrame:accountRect];
    [accountTF setBackground:[UIImage imageNamed:@"table_up@2x"]];
    [accountTF setBackgroundColor:[UIColor clearColor]];
    [accountTF setLeftLabelWithText:@"  账号               "];
    accountTF.font = [UIFont systemFontOfSize:textFontSize];
    accountTF.text = [XCommon UserDefaultGetValueFromKey:NIKENAME];
    accountTF.enabled = NO;
    [_baseView addSubview:accountTF];
    
    CGRect telRect = CGRectOffset(accountRect, 0, TFHeight-1);
    _pwdTF = [[UITextField alloc]initWithFrame:telRect];
    [_pwdTF setBackground:[UIImage imageNamed:@"table_up@2x"]];
    [_pwdTF setBackgroundColor:[UIColor clearColor]];
    [_pwdTF setLeftLabelWithText:@"  原密码           "];
    _pwdTF.secureTextEntry = YES;
    _pwdTF.placeholder = @"请输入原密码";
    _pwdTF.font = [UIFont systemFontOfSize:textFontSize];
    _pwdTF.delegate = self;
    _pwdTF.tag = 101;
    _pwdTF.returnKeyType = UIReturnKeyNext;
    [_baseView addSubview:_pwdTF];
    
    CGRect lineRect = CGRectOffset(telRect, 0, TFHeight-1);
    lineRect.size.height = 1;
    UIImageView *lineImgView = [[UIImageView alloc]initWithFrame:lineRect];
    [lineImgView setImage:[UIImage imageNamed:@"table_line@2x"]];
    [_baseView addSubview:lineImgView];
    
    CGRect pswRect = CGRectOffset(telRect, 0, TFHeight);
    _newPwdTF = [[UITextField alloc]initWithFrame:pswRect];
    [_newPwdTF setBackground:[UIImage imageNamed:@"table_down@2x"]];
    [_newPwdTF setLeftLabelWithText:@"  新密码           "];
    _newPwdTF.placeholder = @"请输入新密码(6-15位)";
    _newPwdTF.font = [UIFont systemFontOfSize:textFontSize];
    _newPwdTF.delegate = self;
    _newPwdTF.secureTextEntry = YES;
    _newPwdTF.tag = 103;
    _newPwdTF.returnKeyType = UIReturnKeyNext;
    [_baseView addSubview:_newPwdTF];
    
    CGRect rePswRect = CGRectOffset(pswRect, 0, TFHeight);
    _reNewPwdTF = [[UITextField alloc]initWithFrame:rePswRect];
    [_reNewPwdTF setBackground:[UIImage imageNamed:@"table_down@2x"]];
    [_reNewPwdTF setLeftLabelWithText:@"  确认新密码    "];
    _reNewPwdTF.placeholder = @"请再次输入新密码";
    _reNewPwdTF.font = [UIFont systemFontOfSize:textFontSize];
    _reNewPwdTF.delegate = self;
    _reNewPwdTF.secureTextEntry = YES;
    _reNewPwdTF.tag = 104;
    _reNewPwdTF.returnKeyType = UIReturnKeyDone;
    [_baseView addSubview:_reNewPwdTF];
    
    CGRect findbackRect = CGRectOffset(rePswRect, 0, TFHeight+itemSpace*3);
    UIButton *mofityPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mofityPwdBtn setFrame:findbackRect];
    [mofityPwdBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@""]] forState:UIControlStateNormal];
    [mofityPwdBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@""]] forState:UIControlStateHighlighted];
    [mofityPwdBtn setTitle:@"保存" forState:UIControlStateNormal];
    mofityPwdBtn.titleLabel.font = [UIFont systemFontOfSize:btnFontSize];
    [mofityPwdBtn addTarget:self action:@selector(onMofityPwdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_baseView addSubview:mofityPwdBtn];
}

- (void)onMofityPwdBtnClick:(id)sender
{
    [self requestMofityPwd];
}

- (void)requestMofityPwd
{
    /*
    if (![AFNetworkReachability checkNetworkConnectivity]) {
        [self.view makeToast:KNetwork_NotReachable];
        return;
    }
    
    if ([XCommon isNullString:_pwdTF.text]) {
        [self.view makeToast:@"请输入原密码"];
        return;
    }
    if ([XCommon isNullString:_newPwdTF.text]) {
        [self.view makeToast:@"请输入新密码"];
        return;
    }else if([XCommon isNullString:_reNewPwdTF.text]){
        [self.view makeToast:@"请再次输入新密码"];
        return;
    }else if(![_newPwdTF.text isEqualToString:_reNewPwdTF.text]){
        [self.view makeToast:@"两次输入的新密码不一致，请重新输入"];
        return;
    }
    
    if (_newPwdTF.text.length<6||_newPwdTF.text.length>15) {
        [self.view makeToast:@"新密码的长度不合法，需6-15位"];
        return;
    }
    
    NSURL *baseURL = [NSURL URLWithString:Base_URL];
    NSMutableDictionary *pams = [[NSMutableDictionary alloc]initWithCapacity:2];
    [pams setObject:appDelegate.configInfo.bossId forKey:@"bossId"];
    [pams setObject:[XCommon md5:_pwdTF.text] forKey:@"password"];
    [pams setObject:[XCommon md5:_newPwdTF.text] forKey:@"newPassword"];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    client.parameterEncoding = AFFormURLParameterEncoding;
    [self hudShowWithLabel:@"正在联网..."];
    [client postPath:@"modifyPassword"
          parameters:pams
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 [self hudHidden];
                 NSError *error;
                 NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingAllowFragments error:&error];
                 if (dic==nil) {  //json解析失败
                     [XCommon showAlertWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"%@",error]];
                 }else if (IS_NETREQUEST_SUCCESS([dic objectForKey:@"state"])) {
                     [self.view makeToast:[dic objectForKey:@"msg"]];
                     
                     [XCommon UserDefaultSetValue:_newPwdTF.text forKey:PASSWORD];
                     [self performSelector:@selector(backBtnClick:) withObject:nil afterDelay:1.0];
                 }else{
                     [XCommon showAlertWithTitle:@"温馨提示" message:[dic objectForKey:@"msg"]];
                 }
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 [self netFailureWithError:error];
             }
     ];
    */
}

#pragma UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _reNewPwdTF) {
        if (_isAlreadySlide==NO) {
            [UIView animateWithDuration:0.5 animations:^{
                _baseView.frame = CGRectOffset(_baseView.frame, 0, -50);
            } completion:^(BOOL finished) {
                _isAlreadySlide = YES;
            }];
        }
    }else{
        if (_isAlreadySlide) {
            [UIView animateWithDuration:0.5 animations:^{
                _baseView.frame = CGRectOffset(_baseView.frame, 0, 50);
            } completion:^(BOOL finished) {
                _isAlreadySlide = NO;
            }];
        }
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField==_pwdTF) {
        [_newPwdTF becomeFirstResponder];
        return NO;
    }else if(textField == _newPwdTF){
        [_reNewPwdTF becomeFirstResponder];
        return NO;
    }
    
    if (_isAlreadySlide) {
        [UIView animateWithDuration:0.5 animations:^{
            _baseView.frame = CGRectOffset(_baseView.frame, 0, 50);
        } completion:^(BOOL finished) {
            _isAlreadySlide = NO;
        }];
    }
    
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[_pwdTF resignFirstResponder];
    [_newPwdTF resignFirstResponder];
    [_reNewPwdTF resignFirstResponder];
    
    if (_isAlreadySlide) {
        [UIView animateWithDuration:0.5 animations:^{
            _baseView.frame = CGRectOffset(_baseView.frame, 0, 50);
        } completion:^(BOOL finished) {
            _isAlreadySlide = NO;
        }];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
