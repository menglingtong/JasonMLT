//
//  LTSearchBar.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/17.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTUISearchBar+LTSetSearchBar.h"


@interface LTSearchBar : UIView <UISearchBarDelegate>

/** 搜索框 */
@property (nonatomic, retain) UISearchBar *searchBar;

/** 圆角属性 */
@property (nonatomic, assign) CGFloat cornerRadius;

/** 边框宽度 */
@property (nonatomic, assign) NSInteger borderWidth;

/** 背景颜色 */
@property (nonatomic, retain) UIColor *backgroundColor;

/** 边框颜色 */
@property (nonatomic, retain) UIColor *borderColor;

/** 搜索框获取第一响应者时的遮罩层 */
@property (nonatomic, retain) UIView *searchView;

/** 自定义初始化方法 */
-(instancetype)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius borderWidth:(NSInteger)borderWidth backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor;

@end
