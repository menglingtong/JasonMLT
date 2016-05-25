//
//  LTListOnePicTableViewCell.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/24.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LTMainListModel.h"

@interface LTListOnePicTableViewCell : UITableViewCell

/** 单图 */
@property (nonatomic, retain) UIImageView *oneImageView;

/** 图片标题 */
@property (nonatomic, retain) UILabel *title;

/** 文章来源 */
@property (nonatomic, retain) UILabel *author;

/** model */
@property (nonatomic, retain) LTMainListModel *model;

/** 下边线 */
@property (nonatomic, retain) UILabel *borderBottom;

@end
