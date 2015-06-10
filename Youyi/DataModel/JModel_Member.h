//
//  JMember.h
//  Youyi
//  成员
//  Created by xieguocheng on 14-11-5.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JModel_Member : NSObject
{
    NSUInteger _mId;             //成员编号
    NSString  *_name;           //成员名称
    NSString  *_headUrl;        //成员头像url
    NSMutableArray *_ppArray;   //成员参加的意向
}
@property (nonatomic) NSUInteger mId;
@property (nonatomic) NSString   *name;
@property (nonatomic) NSString   *headUrl;
@property (nonatomic) NSMutableArray *ppArray;
@end
