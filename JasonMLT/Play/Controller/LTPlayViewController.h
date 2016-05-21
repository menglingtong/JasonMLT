//
//  LTPlayViewController.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/11.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseViewController.h"
#import "LTScrollImage.h"

@interface LTPlayViewController : LTBaseViewController

/** 玩乐页面的tableview */
@property (nonatomic, retain) UITableView *playTableView;

/** 玩乐页面的数据连接 */
@property (nonatomic, copy) NSString *playApiUrl;

/** 滚动视图 */
@property (nonatomic, retain) LTScrollImage *scrollImage;

/** 玩乐页面的数据源数组 */
@property (nonatomic, retain) NSMutableArray *playDataSourceArray;

/** 玩乐页面滚动视图数组 */
@property (nonatomic, retain) NSMutableArray *playScrollDataSourceArray;

/** 玩乐滚动视图下面展示的两块菜单数组 */
@property (nonatomic, retain) NSMutableArray *playTowDataSourceArray;


@end
