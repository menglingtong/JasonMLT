//
//  LTMainPicCategoryCell.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/23.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTMainPicModel.h"
#import <UIImageView+WebCache.h>
#import "LTBaseView.h"

@interface LTMainPicCategoryCell : UITableViewCell

/** 下边线 */
@property (nonatomic, retain) UILabel *borderBottom;

/** 图片 */
@property (nonatomic, retain) UIImageView *picImageView;

/** 标题 */
@property (nonatomic, retain) UILabel *title;

/** 来源 */
@property (nonatomic, retain) UILabel *author;

/** indexPath */
@property (nonatomic, assign) NSInteger indexPath;

/** model */
@property (nonatomic, retain) LTMainPicModel *model;


@end
