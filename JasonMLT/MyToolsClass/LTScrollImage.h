//
//  LTScrollImage.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/12.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseView.h"
#import "LTPageControl.h"

@interface LTScrollImage : LTBaseView <UIScrollViewDelegate>

/** 滚动视图数据源数组 存储图片地址 */
@property (nonatomic, retain) NSArray *scrollImageDataSource;

/** 滚动视图的集合视图 */
@property (nonatomic, retain) UIScrollView *scrollImageView;

/** 滚动视图的图片数量 */
@property (nonatomic, assign) NSInteger numOfImage;

/** 滚动视图是否循环滚动 */
@property (nonatomic, assign) BOOL isCirculatory;

/** 滚动视图是否有标题 */
@property (nonatomic, assign) BOOL isHasText;

/** 滚动视图当前图片 */
@property (nonatomic, assign) NSInteger currentPage;

/** 滚动视图的间隔时间 */
@property(nonatomic, assign) NSInteger Stime;

/** 滚动视图pageControl */
@property (nonatomic, retain) LTPageControl *pageControl;

/** 滚动视图的自定义初始化方法 */
- (instancetype) initWithFrame:(CGRect)frame
                    dataSource:(NSArray *)dataSource
                          time:(NSInteger)time
                 isCirculatory:(BOOL)isCirculatory
                     isHasText:(BOOL)isHasText;


@end
