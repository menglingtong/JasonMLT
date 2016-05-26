//
//  LTTopicArticleCell.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/25.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LTTopicArticleModel.h"

@interface LTTopicArticleCell : UITableViewCell

/** title */
@property (nonatomic, retain) UILabel *title;

/** borderBottom */
@property (nonatomic, retain) UILabel *borderBottom;

/** LTTopicArticleModel */
@property (nonatomic, retain) LTTopicArticleModel *model;

@end
