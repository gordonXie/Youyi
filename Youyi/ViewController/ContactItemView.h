
//
//  ContactItemView.h
//  CustomAPP
//
//  Created by xieguocheng on 14-10-30.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactItemView : UIView
@property (nonatomic,strong) UIImageView *bgImgView;
@property (nonatomic,strong) UILabel *nameLabel;

- (void)initBgImgView:(UIImage*)image AndNameLabel:(NSString*)text;
@end
