//
//  LTHotTableViewCell.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/19.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTBaseView.h"
#import "LTHotModel.h"

@interface LTHotTableViewCell : UITableViewCell

/** 下边线,粗线 */
@property (nonatomic, retain) UILabel *borderBottom;

/** 下边线,细线 */
@property (nonatomic, retain) UILabel *borderBottomThin;

/** 下边线,细线2 */
@property (nonatomic, retain) UILabel *borderBottomThin2;

/** 记录当前cell的排序 */
@property (nonatomic, assign) NSInteger *indexPathRow;

/** 标题 */
@property (nonatomic, retain) UILabel *titleLabel;

/** hot news model */
@property (nonatomic, retain) LTHotModel *model;

/** 文章来源 */
@property (nonatomic, retain) UILabel *autherNameLabel;

/** 文章时间 */
@property (nonatomic, retain) UILabel *dateLabel;

/** 评论数 */
@property (nonatomic, retain) UILabel *comment;

/** 图片 */
@property (nonatomic, retain) UIImageView *singImageView;

@end
