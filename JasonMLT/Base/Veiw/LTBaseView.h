//
//  LTBaseView.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/11.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAS_SHORTHAND // 1.对于约束参数可以省去 "mas_"
#define MAS_SHORTHAND_GLOBALS // 2.对于默认的约束参数自动装箱
#import "Masonry.h" // 3.宏必须添加在头文件前面

// 宏定义宽和高
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface LTBaseView : UIView

@end
