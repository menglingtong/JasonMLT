//
//  LTCategoryViewController.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/23.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseViewController.h"

@interface LTMainListCategoryViewController : LTBaseViewController

/** 获取请求连接 */
@property (nonatomic, retain) NSString *url;

/** collectionView */
@property (nonatomic, retain) UICollectionView *mainCollectionView;

/** 数据源数组 */
@property (nonatomic, retain) NSMutableArray *mainDataSourceArray;

@end
