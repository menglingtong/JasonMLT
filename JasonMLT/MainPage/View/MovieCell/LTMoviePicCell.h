//
//  LTMoviePicCell.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/27.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LTMovieModel.h"

@interface LTMoviePicCell : UITableViewCell

/** 作者名字 */
@property (nonatomic, retain) UILabel *autherName;

/** 作者头像 */
@property (nonatomic, retain) UIImageView *capitalImageView;

/** 发布时间 */
@property (nonatomic, retain) UILabel *dateLabel;

/** 文字 */
@property (nonatomic, retain) UILabel *wordContent;

/** 文章图片 */
@property (nonatomic, retain) UIImageView *mainImageView;

/** hot_num */
@property (nonatomic, retain) UILabel *hot_num;

/** hot img */
@property (nonatomic, retain) UIImageView *hot_icon;

/** hot btn */
@property (nonatomic, retain) UIButton *hot;

/** comment_num */
@property (nonatomic, retain) UILabel *comment_num;

/** comment img */
@property (nonatomic, retain) UIImageView *comment_icon;

/** comment btn */
@property (nonatomic, retain) UIButton *comment;

/** like_num */
@property (nonatomic, retain) UILabel *like_num;

/** like img */
@property (nonatomic, retain) UIImageView *like_icon;

/** like btn */
@property (nonatomic, retain) UIButton *like;

/** borderBottom */
@property (nonatomic, retain) UILabel *borderBottom;

/** LTMovieModel */
@property (nonatomic, retain) LTMovieModel *model;

@end
