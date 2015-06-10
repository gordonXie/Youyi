//
//  JModel_Base.h
//  Youyi
//
//  Created by xie on 15/6/10.
//  Copyright (c) 2015年 xieguocheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JModel_Base : NSObject
+ (id)objectWithDictionary:(NSDictionary *)dict;
- (void)initializeWithDic:(NSDictionary*)dict;
@end
