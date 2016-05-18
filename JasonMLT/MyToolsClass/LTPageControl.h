//
//  LTPageControl.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/12.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseView.h"

typedef NS_ENUM(NSUInteger, LTPageControlStyle) {
    LTPageControlStyleCircle = 0,
    LTPageControlStyleSquare,
    LTPageControlStyleImage,
};

@interface LTPageControl : LTBaseView

/** 点的个数 */
@property (nonatomic, assign) NSInteger pageCount;

/** 当前点击的第几个 */
@property (nonatomic, assign) NSInteger currentPage;

/** 点之间的间隔 */
@property (nonatomic, assign) CGFloat pageInteritemSpacing;

/** 点的未选中颜色 */
@property (nonatomic, retain) UIColor *pointColor;

/** 点选中的颜色 */
@property (nonatomic, retain) UIColor *selectedColor;

/** 点的样式 */
@property (nonatomic, assign) LTPageControlStyle pageStyle;

/** 缩略图 */
@property (nonatomic, retain) NSMutableArray *imageArray;


// 自定义初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                    pageStyle:(LTPageControlStyle)pageStyle
                   imageArray:(NSMutableArray *)imageArray;

@end
