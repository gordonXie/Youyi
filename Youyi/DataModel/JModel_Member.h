//
//  JMember.h
//  Youyi
//  成员
//  Created by xieguocheng on 14-11-5.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JModel_Member : NSObject
@property (nonatomic,assign) NSUInteger mId;        //成员编号
@property (nonatomic,strong) NSString   *name;      //成员名称
@property (nonatomic,strong) NSString   *mobile;    //成员手机号
@property (nonatomic,strong) NSString   *headUrl;   //成员头像url
@property (nonatomic,strong) NSMutableArray *ppArray; //成员参加的意向

@end
