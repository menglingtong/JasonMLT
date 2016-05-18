//
//  LTCategoryDetailViewController.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/17.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseViewController.h"
#import "LTCategoryModel.h"
#import "LTSearchBar.h"

@interface LTCategoryDetailViewController : LTBaseViewController

/** 栏目详情tableview */
@property (nonatomic, retain) UITableView *categoryDetailTableView;

/** 详细栏目数据源数组 */
@property (nonatomic, retain) NSArray *categoryDetailDataSourceArray;

/** categoryModel */
@property (nonatomic, retain) LTCategoryModel *model;

/** 自定义搜索框 */
@property (nonatomic, retain) LTSearchBar *searchBar;

@end
