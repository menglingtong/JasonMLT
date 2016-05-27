//
//  LTMoviePicCell.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/27.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTMoviePicCell.h"

#import "LTBaseView.h"

#import "LTMovieAutherModel.h"

#import "LTMovieMediasModel.h"

#import <UIImageView+WebCache.h>

@implementation LTMoviePicCell

- (void)dealloc
{
    [_autherName release];
    [_capitalImageView release];
    [_wordContent release];
    [_dateLabel release];
    [_mainImageView release];
    [_hot_num release];
    [_hot_icon release];
    [_comment_num release];
    [_comment_icon release];
    [_like_num release];
    [_like_icon release];
    [_borderBottom release];
    
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        // 作者名字
        self.autherName = [[UILabel alloc] init];
        
        [self.contentView addSubview:_autherName];
        [_autherName release];
        
        // 作者头像
        self.capitalImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_capitalImageView];
        [_capitalImageView release];
        
        // 发布时间
        self.dateLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:_dateLabel];
        [_dateLabel release];
        
        // 内容
        self.wordContent = [[UILabel alloc] init];
        
        [self.contentView addSubview:_wordContent];
        [_wordContent release];
        
        // 主图片
        self.mainImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_mainImageView];
        [_mainImageView release];
        
        // 热度按钮
        self.hot = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.contentView addSubview:_hot];
        [_hot release];
        
        
        // 评论按钮
        self.comment = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.contentView addSubview:_comment];
        [_comment release];
        
        // 点赞按钮
        self.like = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.contentView addSubview:_like];
        [_like release];
        
        
        
        // 文章热度数字
        self.hot_num = [[UILabel alloc] init];
        
        self.hot_num.frame = CGRectMake((ScreenWidth / 3.0) * 3 / 5.0, ScreenWidth / 27.0, 40, 20);
        [self.hot_num setFont:[UIFont systemFontOfSize:12]];
        self.hot_num.textColor = [UIColor colorWithRed:0.57 green:0.57 blue:0.57 alpha:1.00];
        
        [self.hot addSubview:_hot_num];
        [_hot_num release];
        
        // 文章热度图片
        self.hot_icon = [[UIImageView alloc] init];
        
        self.hot_icon.frame = CGRectMake((ScreenWidth / 3.0) / 3.0, ScreenWidth / 27.0, 20, 20);
        self.hot_icon.image = [UIImage imageNamed:@"eye"];
        
        [self.hot addSubview:_hot_icon];
        [_hot_icon release];
        
        
        
        // 文章评论数
        self.comment_num = [[UILabel alloc] init];
        
        self.comment_num.frame = CGRectMake((ScreenWidth / 3.0) * 3 / 5.0, ScreenWidth / 27.0, 40, 20);
        [self.comment_num setFont:[UIFont systemFontOfSize:12]];
        self.comment_num.textColor = [UIColor colorWithRed:0.57 green:0.57 blue:0.57 alpha:1.00];
        
        [self.comment addSubview:_comment_num];
        [_comment_num release];
        
        // 文章评论图
        self.comment_icon = [[UIImageView alloc] init];
        
        self.comment_icon.frame = CGRectMake((ScreenWidth / 3.0) / 3.0, ScreenWidth / 27.0, 18, 18);
        self.comment_icon.image = [UIImage imageNamed:@"comment"];
        
        [self.comment addSubview:_comment_icon];
        [_comment_icon release];
        
        
        
        
        // 点赞数
        self.like_num = [[UILabel alloc] init];
        
        self.like_num.frame = CGRectMake((ScreenWidth / 3.0) * 3 / 5.0, ScreenWidth / 27.0, 40, 20);
        [self.like_num setFont:[UIFont systemFontOfSize:12]];
        self.like_num.textColor = [UIColor colorWithRed:0.57 green:0.57 blue:0.57 alpha:1.00];
        
        [self.like addSubview:_like_num];
        [_like_num release];
        
        // 点赞图
        self.like_icon = [[UIImageView alloc] init];
        
        self.like_icon.frame = CGRectMake((ScreenWidth / 3.0) / 3.0, ScreenWidth / 27.0, 18, 18);
        self.like_icon.image = [UIImage imageNamed:@"good"];
        
        [self.like addSubview:_like_icon];
        [_like_icon release];
        
        
        
        // 底边线
        self.borderBottom = [[UILabel alloc] init];
        
        [self.contentView addSubview:_borderBottom];
        [_borderBottom release];
        
        
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.capitalImageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(14);
        
        make.top.equalTo(self.contentView).offset(14);
        
        make.width.equalTo(34);
        
        make.height.equalTo(34);
        
    }];
    self.capitalImageView.layer.cornerRadius = 17;
    self.capitalImageView.clipsToBounds = YES;
    
    
    
    [self.autherName makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(15);
        
        make.left.equalTo(self.capitalImageView.right).offset(7);
        
        make.height.equalTo(20);
        
        make.width.equalTo(100);
        
    }];
    self.autherName.textColor = [UIColor colorWithRed:0.11 green:0.68 blue:0.99 alpha:1.00];
    [self.autherName setFont:[UIFont systemFontOfSize:14]];
    
    
    
    [self.dateLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.autherName.bottom).offset(0);
        
        make.left.equalTo(self.capitalImageView.right).offset(7);
        
        make.height.equalTo(16);
        
        make.width.equalTo(100);
        
    }];
    self.dateLabel.textColor = [UIColor colorWithRed:0.73 green:0.73 blue:0.73 alpha:1.00];
    [self.dateLabel setFont:[UIFont systemFontOfSize:12]];
    
    
    
    [self.wordContent makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(21);
        
        make.top.equalTo(self.dateLabel.bottom).offset(6);
        
        make.right.equalTo(self.contentView).offset(-21);
        
        make.height.equalTo(30);
        
    }];
    self.wordContent.textColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.00];
    [self.wordContent setFont:[UIFont systemFontOfSize:14]];
    
    
    
    [self.mainImageView makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.top.equalTo(self.wordContent.bottom).offset(14);
        
        make.bottom.equalTo(self.hot.top).offset(0);
        
    }];
    
    
    
    [self.hot makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        
        make.top.equalTo(self.mainImageView.bottom).offset(0);
        
        make.bottom.equalTo(self.borderBottom.top).offset(0);
        
        make.height.equalTo(43);
        
        make.width.equalTo(ScreenWidth / 3.0);
        
    }];
    
    
    
    [self.comment makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.hot.right).offset(0);
        
        make.top.equalTo(self.mainImageView.bottom).offset(0);
        
        make.bottom.equalTo(self.borderBottom.top).offset(0);
        
        make.height.equalTo(43);
        
        make.right.equalTo(self.like.left).offset(0);
        
    }];
    
    
    
    [self.like makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.top.equalTo(self.mainImageView.bottom).offset(0);
        
        make.bottom.equalTo(self.borderBottom.top).offset(0);
        
        make.height.equalTo(43);
        
        make.width.equalTo(ScreenWidth / 3.0);
        
    }];
    
    
    [self.borderBottom makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.height.equalTo(10);
        
        make.bottom.equalTo(self.contentView).offset(0);
        
    }];
    self.borderBottom.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    
    
}

-(void)setModel:(LTMovieModel *)model
{
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
        
        LTMovieAutherModel *autherModel = [model.autherModelArray firstObject];
        
        self.autherName.text = autherModel.name;
        
        NSURL *iconUrl = [NSURL URLWithString:autherModel.icon];
        
        [self.capitalImageView sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"placehoderYellow"]];
        
        self.dateLabel.text = model.date;
        
        self.wordContent.text = model.content;
        [self.wordContent sizeToFit];
        
        self.hot_num.text = model.hot_num;
        
        self.comment_num.text = model.comment_count;
        
        self.like_num.text = model.like_num;
        
        // 判断有图片
        if (model.mediaModelArray != nil && model.mediaModelArray.count > 0) {
            
            LTMovieMediasModel *mediaModel = [model.mediaModelArray firstObject];
            
            CGFloat scale = [mediaModel.w integerValue] * 1.0 / [mediaModel.h integerValue] * 1.0;
            
            CGFloat height = ScreenWidth / scale;
            
            [self.mainImageView makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self.contentView).offset(0);
                
                make.right.equalTo(self.contentView).offset(0);
                
                make.top.equalTo(self.wordContent.bottom).offset(14);
                
                make.height.equalTo(height);
                
            }];
            
            NSURL *mainPicUrl = [NSURL URLWithString:mediaModel.url];
            
            [self.mainImageView sd_setImageWithURL:mainPicUrl placeholderImage:[UIImage imageNamed:@"placehoderYellow"]];
            
        }
        
        
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
