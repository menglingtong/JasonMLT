//
//  LTHotNewsViewController.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/11.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseViewController.h"

@interface LTHotNewsViewController : LTBaseViewController

/** 热点界面的tableview */
@property (nonatomic, retain) UITableView *hotTableView;

/** 热点界面的数据源数组 */
@property (nonatomic, retain) NSMutableArray *hotDataSourceArray;


@end
