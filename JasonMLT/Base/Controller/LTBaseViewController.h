//
//  LTBaseViewController.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/11.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>
// 宏定义宽和高
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define UIColorFromRGBA(rgbValue, alphaValue)[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]

#define TEXT_COLOR_NORMAL [UIColor colorWithRed:0.17 green:0.12 blue:0.03 alpha:1.00]

#define TEXT_COLOR_DARK [UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1.00]

#define TEXT_LIGHT_COLOR_NORMAL [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.00];


#define VIEW_BACKGROUND_NORMAL [UIColor whiteColor]

#define VIEW_BACKGROUND_DARK [UIColor colorWithRed:0.08 green:0.08 blue:0.08 alpha:1.00]

#define CELL_BACKGROUND_NORMAL [UIColor whiteColor]

#define CELL_BACKGROUND_DARK [UIColor colorWithRed:0.12 green:0.13 blue:0.13 alpha:1.00]

#import <WebKit/WebKit.h>

#import "EATheme.h"

@interface LTBaseViewController : UIViewController

@end
