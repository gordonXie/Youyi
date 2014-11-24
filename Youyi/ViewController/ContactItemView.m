//
//  ContactItemView.m
//  CustomAPP
//
//  Created by xieguocheng on 14-10-30.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "ContactItemView.h"

@implementation ContactItemView

-(id)initWithFrame:(CGRect)frame withBgImage:(UIImage*)image withText:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        _bgImgView = [[UIImageView alloc]init];
        [_bgImgView setImage:image];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = text;
    }
    
    return self;
}

- (void)initBgImgView:(UIImage*)image AndNameLabel:(NSString*)text
{
    self.backgroundColor = [UIColor clearColor];
    _bgImgView = [[UIImageView alloc]init];
    [_bgImgView setImage:image];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.text = text;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [_bgImgView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_bgImgView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_bgImgView];
    
    [_nameLabel setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_nameLabel setBackgroundColor:[UIColor clearColor]];
    _nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:_nameLabel];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
}


@end
