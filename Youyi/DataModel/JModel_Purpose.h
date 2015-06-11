//
//  JPurpose.h
//  Youyi
//  意向
//  Created by xieguocheng on 14-11-5.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JModel_PPForm.h"
#import "JModel_Member.h"
#import "JModel_Base.h"

typedef struct
{
    NSUInteger  startTime;  //(以分为单位) 在00:00---24:00之前
    NSUInteger  endTime;    //结束时间必须大于开始时间
}PTimeSection;

@interface JModel_Purpose : JModel_Base
{
    NSUInteger      _ppId;          //意向编号,是在创建完成后自动生成的      从101开始，100之前为预留编号
    NSString        *_name;         //名称   (1-9个字符)
    NSString        *_actionVerb;   //意向达成时的个性动词，在意向界面中心显示，用来展示个性(1-2个字符)
    NSMutableArray  *_memberArray;  //意向成员
    NSString        *_ppDesc;       //意向描述
    NSUInteger      _duration;     //持续时间（以天为单位）可选择:2周，3周，1月，2月，3月，6月
    NSUInteger      _cycle;        //重复(以天为单位) 可选择:每天，每两天，每三天，每周，每两周，每月
    PTimeSection     _timeSection;    //时间段，在哪段时间内有效，默认是00:00---24:00

//    JPPForm         *_ppForm;       //意向达成情况回顾表单   是否可从成员数据中获取，其成员在该意向下的完成情况
}
@property (nonatomic,assign) NSUInteger    ppId;
@property (nonatomic,strong) NSString      *name;
@property (nonatomic,strong) NSString      *actionVerb;
@property (nonatomic,strong) NSMutableArray *memberArray;
@property (nonatomic,strong) NSString      *ppDesc;
@property (nonatomic,assign) NSUInteger    duration;
@property (nonatomic,assign) NSUInteger    cycle;
@property (nonatomic,assign) PTimeSection timeSection;
@property (nonatomic,assign) BOOL          isEnable;  //是否可用(关闭或过期时为不可用)

@end
