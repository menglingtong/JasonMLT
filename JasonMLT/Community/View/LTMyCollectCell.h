//
//  LTMyCollectCell.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/28.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTMyCollectCell : UITableViewCell

@property (nonatomic, retain) UILabel *title;

@property (nonatomic, retain) UILabel *borderBottom;

@property (nonatomic, retain) UIImageView *arrow;

@property (nonatomic, copy) NSString *string;

@property (nonatomic, retain) UILabel *tempCachLabel;

@property (nonatomic, copy) NSString *tempCacheStr;

@end
