//
//  LTMainMenuCollectionCell.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/14.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTMainMenuCollectionCell : UICollectionViewCell

/** 编辑模式下,显示在右上角的原点 */
@property (nonatomic, retain) UIImageView *isEditImage;

/** 菜单的名字 */
@property (nonatomic, retain) UILabel *menuNameLabel;

/** 判断cell是否被选中 */
@property (nonatomic, assign) BOOL isSelected;

/** 右边线 */
@property (nonatomic, retain) UILabel *borderRight;

/** 下边线 */
@property (nonatomic, retain) UILabel *borderBottom;

/** 当前cell的排序 */
@property (nonatomic, assign) NSInteger indexPathOfItem;

@end
