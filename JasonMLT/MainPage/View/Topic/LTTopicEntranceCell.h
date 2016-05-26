//
//  LTTopicEntranceCell.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/25.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LTTopicEntranceModel.h"

@interface LTTopicEntranceCell : UITableViewCell

/** 标题 */
@property (nonatomic, retain) UILabel *title;

/** 右侧箭头 */
@property (nonatomic, retain) UIImageView *imageArrow;

/** LTTopicEntranceModel */
@property (nonatomic, retain) LTTopicEntranceModel *model;

@end
