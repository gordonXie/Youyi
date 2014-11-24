//
//  ContactUsViewController.m
//  CustomAPP
//
//  Created by xieguocheng on 14-10-29.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "ContactUsViewController.h"


@interface ContactUsViewController ()
{
    UIScrollView *_baseScrollView;
    NSDictionary *_infoDic;
}
@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addBackBtn];
    self.titleLabel.text = @"联系我们";
    
    [self initItems];
    
    [self requestInfo];
}

-(void)initItems
{
    const float fontSize = 14.0;
    _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, CONTENT_HEIGHT)];
    [self.view addSubview:_baseScrollView];
    
    float startH = 0.0;
    const float leftEdge = 10.0;
    const float iconImageHeight = 180.0;
    _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, startH, SCREEN_WIDTH, iconImageHeight)];
//    [_iconImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_contact_bigImage@2x",appDelegate.configInfo.colorType]]];
    [_baseScrollView addSubview:_iconImageView];
    startH += iconImageHeight+20;
    
    const float itemTitleWidth = 80.0;
    const float itemTitleHeight = 23.0;
    const float itemEdge = 10.0;
    UIImage *itemBgImg = [UIImage imageNamed:[NSString stringWithFormat:@"contact_item_bg@2x"]];
    _companyItem = [[ContactItemView alloc]initWithFrame:CGRectMake(leftEdge, startH, itemTitleWidth, itemTitleHeight)];
    [_baseScrollView addSubview:_companyItem];
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(itemTitleWidth+leftEdge*2, startH, SCREEN_WIDTH-itemTitleWidth-leftEdge*3, itemTitleHeight)];
    _nameLabel.font = [UIFont systemFontOfSize:fontSize];
    [_baseScrollView addSubview:_nameLabel];
    [_companyItem initBgImgView:itemBgImg AndNameLabel:@"企业名称"];
    startH += itemTitleHeight+itemEdge;

    const float arrowSize = 15.0;
    _telephoneItem = [[ContactItemView alloc]initWithFrame:CGRectMake(leftEdge, startH, itemTitleWidth, itemTitleHeight)];
    [_baseScrollView addSubview:_telephoneItem];
    _telLabel = [[UILabel alloc]initWithFrame:CGRectMake(itemTitleWidth+leftEdge*2, startH, SCREEN_WIDTH-itemTitleWidth-leftEdge*3-arrowSize, itemTitleHeight)];
    _telLabel.font = [UIFont systemFontOfSize:fontSize];
    [_baseScrollView addSubview:_telLabel];
    _telArrowImgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-leftEdge-arrowSize, startH+(itemTitleHeight-arrowSize)/2.0, arrowSize, arrowSize)];
    [_baseScrollView addSubview:_telArrowImgView];
    [_telephoneItem initBgImgView:itemBgImg AndNameLabel:@"电话"];
        startH += itemTitleHeight+itemEdge;
    
    _emailItem = [[ContactItemView alloc]initWithFrame:CGRectMake(leftEdge, startH, itemTitleWidth, itemTitleHeight)];
    [_baseScrollView addSubview:_emailItem];
    _eMailLabel = [[UILabel alloc]initWithFrame:CGRectMake(itemTitleWidth+leftEdge*2, startH, SCREEN_WIDTH-itemTitleWidth-leftEdge*3, itemTitleHeight)];
    _eMailLabel.font = [UIFont systemFontOfSize:fontSize];
    [_baseScrollView addSubview:_eMailLabel];
    [_emailItem initBgImgView:itemBgImg AndNameLabel:@"邮箱"];
        startH += itemTitleHeight+itemEdge;
    
    _webItem = [[ContactItemView alloc]initWithFrame:CGRectMake(leftEdge, startH, itemTitleWidth, itemTitleHeight)];
    [_baseScrollView addSubview:_webItem];
    _webLabel = [[UILabel alloc]initWithFrame:CGRectMake(itemTitleWidth+leftEdge*2, startH, SCREEN_WIDTH-itemTitleWidth-leftEdge*3, itemTitleHeight)];
    _webLabel.font = [UIFont systemFontOfSize:fontSize];
    [_baseScrollView addSubview:_webLabel];
    _webArrowImgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-leftEdge-arrowSize, startH+(itemTitleHeight-arrowSize)/2.0, arrowSize, arrowSize)];
    [_baseScrollView addSubview:_webArrowImgView];
    [_webItem initBgImgView:itemBgImg AndNameLabel:@"网站"];
        startH += itemTitleHeight+itemEdge;
    
    _addressItem = [[ContactItemView alloc]initWithFrame:CGRectMake(leftEdge, startH, itemTitleWidth, itemTitleHeight)];
    [_baseScrollView addSubview:_addressItem];
    _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(itemTitleWidth+leftEdge*2, startH, SCREEN_WIDTH-itemTitleWidth-leftEdge*3, itemTitleHeight)];
    _addressLabel.font = [UIFont systemFontOfSize:fontSize];
    [_baseScrollView addSubview:_addressLabel];
    [_addressItem initBgImgView:itemBgImg AndNameLabel:@"地址"];
        startH += itemTitleHeight+itemEdge;
    
    UIImage *arrowImg = [UIImage imageNamed:[NSString stringWithFormat:@"_contact_arrow@2x"]];
    [_telArrowImgView setImage:arrowImg];
    [_webArrowImgView setImage:arrowImg];
}

- (void)refreshContactInfo:(NSDictionary*)infoDic
{
    _nameLabel.text = [infoDic objectForKey:@"name"];
    _telLabel.text = [infoDic objectForKey:@"phoneNumber"];
    _eMailLabel.text = [infoDic objectForKey:@"mail"];
    _webLabel.text = [infoDic objectForKey:@"website"];
    _addressLabel.text = [infoDic objectForKey:@"address"];
    float addressHeight = [XCommon heightForString:_addressLabel.text fontSize:17 andWidth:_addressLabel.frame.size.width];
    if (addressHeight>_addressLabel.frame.size.height)
    {
        _addressLabel.numberOfLines = 0;
        [_addressLabel setFrame:CGRectMake(_addressLabel.frame.origin.x, _addressLabel.frame.origin.y, _addressLabel.frame.size.width, addressHeight)];
    }
    
    // single tap gesture recognizer
    UITapGestureRecognizer *telTapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(telTapGestureRecognizer:)];
    telTapGestureRecognize.delegate = self;
    telTapGestureRecognize.numberOfTapsRequired = 1;
    _telLabel.userInteractionEnabled = YES;
    [_telLabel addGestureRecognizer:telTapGestureRecognize];
    
    // single tap gesture recognizer
    UITapGestureRecognizer *webTapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(webTapGestureRecognizer:)];
    webTapGestureRecognize.delegate = self;
    webTapGestureRecognize.numberOfTapsRequired = 1;
    _webLabel.userInteractionEnabled = YES;
    [_webLabel addGestureRecognizer:webTapGestureRecognize];
}

- (void)telTapGestureRecognizer:(id)sender
{
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_telLabel.text ]]];
}

- (void)webTapGestureRecognizer:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_webLabel.text]];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://baidu.com"]]; //www.baidu.com 就打不开，格式不对
}

- (void)requestInfo
{
    /*
    NSURL *baseURL = [NSURL URLWithString:Base_URL];
    
    NSMutableDictionary *pams = [[NSMutableDictionary alloc]initWithCapacity:2];
    [pams setObject:appDelegate.configInfo.bossId forKey:@"bossId"];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    client.parameterEncoding  = AFFormURLParameterEncoding;
    [self hudShowWithLabel:@"正在联网..."];
    [client postPath:@"contact"
          parameters:pams
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 [self hudHidden];
                 NSError *error;
                 NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingAllowFragments error:&error];
                 if (dic==nil) {  //json解析失败
                     [XCommon showAlertWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"%@",error]];
                 }else if (IS_NETREQUEST_SUCCESS([dic objectForKey:@"state"])) {
//                     _infoDic = [NSDictionary dictionaryWithDictionary:[dic objectForKey:@"companyInfo"]];
                     [self refreshContactInfo:[dic objectForKey:@"companyInfo"]];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
