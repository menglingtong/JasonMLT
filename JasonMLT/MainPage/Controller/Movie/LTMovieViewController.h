//
//  LTMovieViewController.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/27.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseViewController.h"

@interface LTMovieViewController : LTBaseViewController

/** 数据源数组 */
@property (nonatomic, retain) NSMutableArray *dataSourceArray;

/** tableview */
@property (nonatomic, retain) UITableView *mainTableView;

/** 链接 */
@property (nonatomic, copy) NSString *url;

/** 标题 */
@property (nonatomic, copy) NSString *categoryTitle;


/** bottom backBar */
@property (nonatomic, retain) UIView *backBar;

/** back button */
@property (nonatomic, retain) UIButton *backBtn;

/** refresh button */
@property (nonatomic, retain) UIButton *refreshBtn;

@end
