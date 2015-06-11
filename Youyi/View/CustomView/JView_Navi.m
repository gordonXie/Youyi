//
//  JView_Navi.m
//  Youyi
//
//  Created by xie on 15/6/11.
//  Copyright (c) 2015年 xieguocheng. All rights reserved.
//

#import "JView_Navi.h"
#import "CustomConfig.h"

#define BTitleFont [UIFont systemFontOfSize:14]
#define BTitleColor RGBCOLORV(0x666666)

@interface JView_Navi ()
@property (strong, nonatomic) UIView* selectBgView;
@end

@implementation JView_Navi
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    UIView* view = [self viewWithTag:1000+selectedIndex];
    [UIView animateWithDuration:0.2 animations:^{
        _selectBgView.center = CGPointMake(view.center.x, _selectBgView.center.y);
    }];
}
- (void)setTitleArray:(NSArray *)titleArray {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (!titleArray.count) {
        return;
    }
    [_selectBgView removeFromSuperview];
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.frame)/titleArray.count, CGRectGetHeight(self.frame)-2);
    
    for (NSString* string in titleArray) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = rect;
        [button.titleLabel setFont:BTitleFont];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitleColor:BTitleColor forState:UIControlStateNormal];
        [button setTag:1000+[titleArray indexOfObject:string]];
        [button setTitle:string forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        rect.origin.x += rect.size.width;
    }
    _selectBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-2, CGRectGetWidth(rect), 2)];
    [_selectBgView setBackgroundColor:COLOR_GREEN_FH];
    [self addSubview:_selectBgView];
}
- (void)buttonAction:(UIButton*)button {
    if (_selectBgView.center.x != button.center.x &&self.delegate &&[self.delegate respondsToSelector:@selector(naviViewSelected:)]) {
        [self.delegate naviViewSelected:button.tag-1000];
    }
    [UIView animateWithDuration:0.2 animations:^{
        _selectBgView.center = CGPointMake(button.center.x, _selectBgView.center.y);
    }];
}
@end
