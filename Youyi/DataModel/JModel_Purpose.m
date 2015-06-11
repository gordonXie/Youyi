//
//  JPurpose.m
//  Youyi
//
//  Created by xieguocheng on 14-11-5.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "JModel_Purpose.h"

@implementation JModel_Purpose
@synthesize ppId = _ppId;
@synthesize name = _name;
@synthesize actionVerb = _actionVerb;
@synthesize memberArray = _memberArray;
@synthesize ppDesc = _ppDesc;
@synthesize duration = _duration;
@synthesize cycle = _cycle;
@synthesize timeSection = _timeSection;
@synthesize isEnable = _isEnable;

- (void)initializeWithDic:(NSDictionary*)dic {
    self.memberArray = [NSMutableArray array];
}

@end
