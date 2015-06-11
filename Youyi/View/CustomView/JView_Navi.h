//
//  JView_Navi.h
//  Youyi
//
//  Created by xie on 15/6/11.
//  Copyright (c) 2015年 xieguocheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JView_NaviDelegate <NSObject>
- (void)naviViewSelected:(NSInteger)selectIndex;
@end

@interface JView_Navi : UIView
@property (strong, nonatomic) NSArray* titleArray;
@property (assign, nonatomic) NSUInteger sum;
@property (weak, nonatomic) id<JView_NaviDelegate> delegate;
@property (assign, nonatomic) NSUInteger selectedIndex;

- (void)setSelectedIndex:(NSUInteger)index;
@end
