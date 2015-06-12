//
//  PurposeCreateViewController.h
//  Youyi
//
//  Created by xieguocheng on 14-11-6.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "JBaseViewController.h"
#import "HomeViewController.h"
@class JModel_Purpose;

@interface PurposeCreateViewController : JBaseViewController
@property (nonatomic,copy) NSString *timeSectionStart;
@property (nonatomic,copy) NSString *timeSectionEnd;
@property (nonatomic,strong) JModel_Purpose *purpose;

@property (nonatomic) HomeViewController       *homeVC;
@end
