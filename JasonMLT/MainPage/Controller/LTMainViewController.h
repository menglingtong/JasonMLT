//
//  LTMainViewController.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/11.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseViewController.h"
#import "LTScrollImage.h"

@interface LTMainViewController : LTBaseViewController

/** 主界面菜单按钮数据源数组 */
@property (nonatomic, retain) NSMutableArray *mainMenuDataSourceArray;

/** 主界面菜单编辑模式下,选中删除的按钮字典 */
@property (nonatomic, retain) NSMutableDictionary *mainMenuWillDeleteDictionary;

/** 主界面菜单编辑模式下,选中删除的按钮存储indexPath数组 */
@property (nonatomic, retain) NSMutableArray *mainMenuWillDeleteArray;

/** 主界面菜单的集合视图 */
@property (nonatomic, retain) UICollectionView *mainMenuCollectionView;

/** 编辑模式下下侧弹出层 */
@property (nonatomic, retain) UIView *editView;

/** BOOL类型 判断是否处于编辑模式 */
@property (nonatomic, assign) BOOL isEditing;

/** 编辑模式下确认删除按钮 */
@property (nonatomic, retain) UIButton *deleteConfirm;

/** 编辑模式下退出编辑按钮 */
@property (nonatomic, retain) UIButton *exitEditing;

/** mainMenuCollectionCell 移动中的临时cell */
@property (nonatomic, retain) UIView *tempMovingCell;

/** 记录上一次点击的位置 */
@property (nonatomic, assign) CGPoint lastPoint;

/** 记录拖拽的cell */
@property (nonatomic, retain) NSIndexPath *pointedCellIndexPath;

/** 记录放入位置 */
@property (nonatomic, retain) NSIndexPath *moveIndexPath;

/** 滚动视图数据源数组 */
@property (nonatomic, retain) NSMutableArray *scrollViewDataSource;

/** 自定义滚动视图 */
@property (nonatomic, retain) LTScrollImage *scrollImage;

@property (nonatomic, retain) NSArray *imageClassArray;

@property (nonatomic, retain) NSArray *tableClassArray;


@end
