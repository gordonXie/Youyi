//
//  ContactUsViewController.h
//  CustomAPP
//
//  Created by xieguocheng on 14-10-29.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "JBaseViewController.h"
#import "ContactItemView.h"

@interface ContactUsViewController : JBaseViewController
@property (strong, nonatomic)  UIImageView *iconImageView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *telLabel;
@property (strong, nonatomic)  UILabel *eMailLabel;
@property (strong, nonatomic)  UILabel *webLabel;
@property (strong, nonatomic)  UILabel *addressLabel;

@property (strong, nonatomic)  UIImageView *telArrowImgView;
@property (strong, nonatomic)  UIImageView *webArrowImgView;

@property (strong, nonatomic)  ContactItemView *companyItem;
@property (strong, nonatomic)  ContactItemView *telephoneItem;
@property (strong, nonatomic)  ContactItemView *emailItem;
@property (strong, nonatomic)  ContactItemView *webItem;
@property (strong, nonatomic)  ContactItemView *addressItem;

@end
