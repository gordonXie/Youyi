//
//  JView_MyPicker.m
//  YYPlatform
//
//  Created by auda on 14/12/22.
//  Copyright (c) 2014年 YouYi. All rights reserved.
//

#import "JView_MyPicker.h"
#import "CustomConfig.h"

#define P_Bg_Color RGBCOLORV(0x666666)

//屏幕的宽度
#define PScreenWidth ([UIScreen mainScreen].bounds.size.width)
//屏幕的高度
#define PScreenHeight ([UIScreen mainScreen].bounds.size.height)
//边距
#define PEdgeDistance 10

@interface JView_MyPicker ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, assign)CGRect originRect;
@property (strong, nonatomic) UIPickerView* picker;
@property (assign, nonatomic) BOOL showPicker;
@end

@implementation JView_MyPicker

- (instancetype)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat tooLH = KPicker_View_Height-KPicker_Height;
        CGFloat buttonH = 30;
        CGFloat buttonW = 60;
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, PScreenWidth, tooLH)];
        view.backgroundColor = P_Bg_Color;
        [self addSubview:view];
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(PEdgeDistance, (tooLH-buttonH)/2, buttonW, buttonH);
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cancelAcion) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        UIButton* button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(PScreenWidth-buttonW-PEdgeDistance, (tooLH-buttonH)/2, buttonW, buttonH);
        [button2 setTitle:@"确定" forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button2];

        
        _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, tooLH, PScreenWidth, KPicker_Height)];
        [self addSubview:_picker];
        _picker.showsSelectionIndicator = YES;
        _picker.dataSource = self;
        _picker.delegate  =self;
    }
    return self;
}
- (void)reloadAllComponents {
    [self.picker reloadAllComponents];
}
- (void)show {
    if (_showPicker) {
        return;
    }
    self.showPicker = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.frame = CGRectMake(0, PScreenHeight, PScreenWidth, KPicker_Height);
    [UIView animateWithDuration:0.3 animations:^{
       self.frame = CGRectMake(0, PScreenHeight-KPicker_Height, PScreenWidth, KPicker_Height);
    }];
}
- (void)dismiss {
    if (_showPicker) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(0, PScreenHeight, PScreenWidth, KPicker_Height);
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
    }
    self.showPicker = NO;
}
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.dataSource.count) {
        return self.dataSource.count;
    }
    return 1;
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (row<self.dataSource.count) {
         return [self.dataSource objectAtIndex:row];
    }
    return nil;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.didSelectRow = row;
}

- (void)cancelAcion {
    if (self.delegate) {
        [self.delegate JPickerDismiss:self cancel:YES];
    }
    [self dismiss];
}
- (void)okAction {
    if (self.delegate&&self.dataSource.count) {
        [self.delegate JPickerDismiss:self cancel:NO];
    }
    [self dismiss];
}
@end
