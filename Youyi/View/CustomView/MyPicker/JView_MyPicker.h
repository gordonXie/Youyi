//
//  JView_MyPicker.h
//  YYPlatform
//
//  Created by auda on 14/12/22.
//  Copyright (c) 2014年 YouYi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KPicker_Height 256
#define KPicker_View_Height (KPicker_Height+40)

@class JView_MyPicker;
@protocol JView_MyPickerDelegate <NSObject>

- (void)JPickerDismiss:(JView_MyPicker*)picker cancel:(BOOL)cancel;

@end


@interface JView_MyPicker : UIView

@property (weak, nonatomic) id<JView_MyPickerDelegate>  delegate;
@property (assign, nonatomic,readonly) BOOL showPicker;
@property (assign, nonatomic) NSInteger didSelectRow;
@property (strong, nonatomic,readonly) UIPickerView* picker;
@property (nonatomic, strong) NSArray * dataSource;

- (void)show;
- (void)dismiss;
- (void)reloadAllComponents;
@end
