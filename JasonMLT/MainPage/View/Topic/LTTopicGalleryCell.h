//
//  LTTopicGalleryCell.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/25.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LTTopicGalleryModel.h"

@interface LTTopicGalleryCell : UITableViewCell

/** 图片 */
@property (nonatomic, retain) UIImageView *galleryImageView;

/** 文字 */
@property (nonatomic, retain) UILabel *title;

/** model */
@property (nonatomic, retain) LTTopicGalleryModel *model;

@end
