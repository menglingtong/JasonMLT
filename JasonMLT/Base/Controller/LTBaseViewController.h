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

#import <WebKit/WebKit.h>

@interface LTBaseViewController : UIViewController

@end
