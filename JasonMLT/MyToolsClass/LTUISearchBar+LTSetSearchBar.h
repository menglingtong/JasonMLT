//
//  LTUISearchBar+LTSetSearchBar.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/17.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IS_IOS9 [[UIDevice currentDevice].systemVersion doubleValue] >= 9

#pragma mark -
#pragma mark searchBar类目方法定义
@interface UISearchBar (LTSetSearchBar)

/** 设置字体 */
- (void)LTSetTextFont:(UIFont *)font;

/** 设置字色 */
- (void)LTSetTextColor:(UIColor *)textColor;

/** 设置文字内容 */
- (void)LTSetCancelButtonTitle:(NSString *)title;

@end
