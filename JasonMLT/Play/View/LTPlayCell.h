//
//  LTPlayCell.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/21.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTPlayModel.h"

@interface LTPlayCell : UITableViewCell

/** 玩乐的图片 */
@property (nonatomic, retain) UIImageView *LTImageView;

/** 图片灰色遮罩层 */
@property (nonatomic, retain) UIView *grayView;

/** 玩乐的title 大字 */
@property (nonatomic, retain) UILabel *LTtitleLabel;

/** 玩乐的content 小字 */
@property (nonatomic, retain) UILabel *LTcontentLabel;

/** 记录当前cell的排序 */
@property (nonatomic, retain) NSIndexPath *indexPath;

/** 赋值用的model */
@property (nonatomic, retain) LTPlayModel *model;

@end
