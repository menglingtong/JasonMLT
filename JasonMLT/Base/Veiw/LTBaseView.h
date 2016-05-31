//
//  LTBaseView.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/11.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EATheme.h"

#define MAS_SHORTHAND // 1.对于约束参数可以省去 "mas_"
#define MAS_SHORTHAND_GLOBALS // 2.对于默认的约束参数自动装箱
#import "Masonry.h" // 3.宏必须添加在头文件前面

#import "LTArchiver.h"

// 宏定义宽和高
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define UIColorFromRGBA(rgbValue, alphaValue)[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]

#define TEXT_COLOR_NORMAL [UIColor colorWithRed:0.17 green:0.12 blue:0.03 alpha:1.00]

#define TEXT_COLOR_DARK [UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1.00]

#define VIEW_BACKGROUND_NORMAL [UIColor whiteColor]

#define VIEW_BACKGROUND_DARK [UIColor colorWithRed:0.08 green:0.08 blue:0.08 alpha:1.00]

#define CELL_BACKGROUND_NORMAL [UIColor whiteColor]

#define CELL_BACKGROUND_DARK [UIColor colorWithRed:0.12 green:0.13 blue:0.13 alpha:1.00]

#define BORDER_COLOR_NORMAL

#define BORDER_COLOR_DARK


@interface LTBaseView : UIView

@end
