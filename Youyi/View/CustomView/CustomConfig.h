//
//  CustomConfig.h
//  Youyi
//
//  Created by xie on 15/6/11.
//  Copyright (c) 2015年 xieguocheng. All rights reserved.
//

#ifndef Youyi_CustomConfig_h
#define Youyi_CustomConfig_h

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define RGBCOLORV(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]
#define RGBCOLORVA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

/**< 颜色 */
#define  CLEAR_BACKGROUND_COLOR [UIColor clearColor]

#define COLOR_REDBUTTON         RGBCOLOR(252, 110, 81)
#define COLOR_GREEN_FH          RGBCOLOR(161, 211, 110)
#define COLOR_RED_FH            RGBCOLOR(252, 110, 81)
#define COLOR_BLUE_Light_FH     RGBCOLOR(79, 193, 233)
#define COLOR_BLUE_FH           RGBCOLOR(93, 156, 236)
#define COLOR_BACKGROUND        RGBCOLOR(242, 242, 242)
#define COLOR_Line              RGBCOLOR(210,210,221)
#define COLOE_WHITECOLOR        [UIColor whiteColor]
#define COLOR_GRAY_FH           RGBCOLORV(0x333333)

#endif
