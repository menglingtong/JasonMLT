//
//  LTCategoryTableViewCell.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/17.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTCategoryModel.h"

#define MAS_SHORTHAND // 1.对于约束参数可以省去 "mas_"
#define MAS_SHORTHAND_GLOBALS // 2.对于默认的约束参数自动装箱
#import "Masonry.h" // 3.宏必须添加在头文件前面

@interface LTCategoryTableViewCell : UITableViewCell

/** categoryTitleLabel */
@property (nonatomic, retain) UILabel *categoryTitleLabel;

/** 右侧箭头 */
@property (nonatomic, retain) UIImageView *arrow;

/** model */
@property (nonatomic, retain) LTCategoryModel *model;

/** 分割线 */
@property (nonatomic, retain) UILabel *separatorLine;

@end
