//
//  LTEntranceOnePicCell.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/26.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LTTopicEntranceListModel.h"

@interface LTEntranceOnePicCell : UITableViewCell

@property (nonatomic, retain) UILabel *title;

@property (nonatomic, retain) UILabel *author;

@property (nonatomic, retain) UIImageView *picImageView;

@property (nonatomic, retain) LTTopicEntranceListModel *model;

@property (nonatomic, retain) UILabel *borderBottom;

@end
