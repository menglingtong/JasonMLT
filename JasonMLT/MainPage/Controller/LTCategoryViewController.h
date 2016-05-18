//
//  LTCategoryViewController.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/16.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseViewController.h"
#import "LTSearchBar.h"

#import "LTCategoryModel.h"

@interface LTCategoryViewController : LTBaseViewController

/** 栏目页面的tableview */
@property (nonatomic, retain) UITableView *categoryTableView;

/** 栏目数据源数组 */
@property (nonatomic, retain) NSMutableArray *categoryDataSource;

/** 即将添加的栏目数组 */
@property (nonatomic, retain) NSMutableArray *willAddDataSource;

/** 自定义搜索框 */
@property (nonatomic, retain) LTSearchBar *searchBar;

/** Category(栏目)model */
//@property (nonatomic, retain) LTCategoryModel *categoryModel;




@end
