//
//  LTMainListCategoryCell.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/24.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LTWebViewDelegate <NSObject>

@required
- (void) getToTheWKWebView:(NSString *)url;

@end

@interface LTMainListCategoryCell : UICollectionViewCell<UITableViewDelegate, UITableViewDataSource>

/** 数据源数组 */
@property (nonatomic, retain) NSArray *dataSource;

/** tableview */
@property (nonatomic, retain) UITableView *mainTableView;

/** 设置代理人属性 */
@property (nonatomic, assign) id<LTWebViewDelegate> LTWebViewDelegate;


@end
