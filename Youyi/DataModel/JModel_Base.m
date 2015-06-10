//
//  JModel_Base.m
//  Youyi
//
//  Created by xie on 15/6/10.
//  Copyright (c) 2015年 xieguocheng. All rights reserved.
//

#import "JModel_Base.h"

@implementation JModel_Base
+ (id)objectWithDictionary:(NSDictionary *)dic {
    if (!dic||![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    JModel_Base* model = [[self alloc] init];
    [model initializeWithDic:dic];
    return model;
}
- (void)initializeWithDic:(NSDictionary*)dic {
    
}
@end
