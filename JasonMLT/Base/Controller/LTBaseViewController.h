//
//  LTBaseViewController.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/11.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DB_NAME @"JasonMLT.sqlite"

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

#import "LTArchiver.h"

#import "EATheme.h"

#define FRONT_IMAGE_API_URL @"http://iphone.myzaker.com/zaker/cover.php?_appid=iphone&_bsize=750_1334&_dev=iPhone%2C9.3.1&_idfa=44C64D22-DBB4-49AD-BB93-DC50565EFC46&_lat=0.000000&_lng=0.000000&_mac=02%3A00%3A00%3A00%3A00%3A00&_net=wifi&_udid=EFF67A40-E743-4850-978E-0E96FC82A7B2&_uid=&_utoken=&_v=6.5.2&_version=6.54&api_version=3.4"

#define SCROLL_URL @"http://iphone.myzaker.com/zaker/follow_promote.php?_appid=iphone&_bsize=750_1334&_dev=iPhone%2C9.3.1&_idfa=44C64D22-DBB4-49AD-BB93-DC50565EFC46&_lat=0.000000&_lng=0.000000&_mac=02%3A00%3A00%3A00%3A00%3A00&_net=wifi&_udid=EFF67A40-E743-4850-978E-0E96FC82A7B2&_uid=&_utoken=&_v=6.5.2&_version=6.54&m=1462848242"

@interface LTBaseViewController : UIViewController

@end
