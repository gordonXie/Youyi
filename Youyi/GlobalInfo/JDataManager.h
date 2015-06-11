//
//  JDataManager.h
//  Youyi
//
//  Created by xie on 15/6/11.
//  Copyright (c) 2015年 xieguocheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JModel_Member;

#define JDATAMGR [JDataManager sharedInstance]

@interface JDataManager : NSObject
+(JDataManager*)sharedInstance;

@property (assign, nonatomic) BOOL  isLogin;
@property (strong, nonatomic) NSString* sessionID;
@property (strong, nonatomic) JModel_Member* user; //用户信息
@property (strong, nonatomic) NSMutableArray* ppArray;      //我的意向数组
- (void)reset;
- (void)parseUserInfo:(NSDictionary*)dic;
@end
