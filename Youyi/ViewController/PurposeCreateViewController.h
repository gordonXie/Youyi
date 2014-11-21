//
//  PurposeCreateViewController.h
//  Youyi
//
//  Created by xieguocheng on 14-11-6.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "JBaseViewController.h"
#import "HomeViewController.h"

@interface PurposeCreateViewController : JBaseViewController
@property (nonatomic) NSString *timeSectionStart;
@property (nonatomic) NSString *timeSectionEnd;

@property (nonatomic) HomeViewController       *homeVC;
@end
