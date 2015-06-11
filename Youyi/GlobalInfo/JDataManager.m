//
//  JDataManager.m
//  Youyi
//
//  Created by xie on 15/6/11.
//  Copyright (c) 2015年 xieguocheng. All rights reserved.
//

#import "JDataManager.h"
#import "JModel_Member.h"
#import "JModel_Purpose.h"

@implementation JDataManager
+(JDataManager*)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self reset];
    }
    return self;
}

- (void)reset {
    self.isLogin = NO;
//    [[NSNotificationCenter defaultCenter] postNotificationName:FHNOTIFICATION_LOGOUT object:nil];
    self.user = [[JModel_Member alloc] init];
    self.ppArray = [NSMutableArray array];

//    NSString* name = [UserDefaults objectForKey:KUSERPHONENUMBER];
//    if (name.length) {
//        self.user.mobile = name;
//    }
}

- (void)parseUserInfo:(NSDictionary*)dic {
    
    NSDictionary *dict = [dic objectForKey:@"data"];
    
    if (dict) {
        self.user.name = [dict objectForKey:@"name"];
        self.user.mId= [[dict objectForKey:@"userId"] integerValue];
        self.user.mobile = [dict objectForKey:@"mobile"];
    }
}
@end
