//
//  LTTopicEntranceListViewController.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/26.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseViewController.h"

@interface LTTopicEntranceListViewController : LTBaseViewController

/** 跳转链接 */
@property (nonatomic, copy) NSString *url;

/** tableView */
@property (nonatomic, retain) UITableView *mainTableView;

/** 数据源数组 */
@property (nonatomic, retain) NSMutableArray *dataSourceArray;

/** bottom backBar */
@property (nonatomic, retain) UIView *backBar;

/** back button */
@property (nonatomic, retain) UIButton *backBtn;

/** refresh button */
@property (nonatomic, retain) UIButton *refreshBtn;


@property (nonatomic, copy) NSString *entranceTitle;


@end
