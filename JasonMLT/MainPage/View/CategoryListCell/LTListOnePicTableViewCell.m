//
//  LTListOnePicTableViewCell.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/24.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTListOnePicTableViewCell.h"

#import "LTBaseView.h"

#import <UIImageView+WebCache.h>

@implementation LTListOnePicTableViewCell

- (void)dealloc
{
    [_title release];
    [_oneImageView release];
    
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.oneImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_oneImageView];
        [_oneImageView release];
        
        self.title = [[UILabel alloc] init];
        
        [self.oneImageView addSubview:_title];
        [_title release];
        
        self.borderBottom = [[UILabel alloc] init];
        
        [self.contentView addSubview:_borderBottom];
        [_borderBottom release];
        
        
        self.author = [[UILabel alloc] init];
        
        [self.contentView addSubview:_author];
        [_author release];
        
        
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.oneImageView makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        
        make.top.equalTo(self.contentView).offset(0);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.bottom.equalTo(self.contentView).offset(-6);
        
    }];
    
    self.oneImageView.backgroundColor = [UIColor grayColor];
    
    [self.title makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.oneImageView).offset(0);
        
        make.right.equalTo(self.oneImageView).offset(0);
        
        make.bottom.equalTo(self.oneImageView).offset(0);
        
        make.height.equalTo(40);
        
    }];
    
    self.title.backgroundColor = [UIColor colorWithRed:0.01 green:0.01 blue:0.01 alpha:0.60];
    
    
    [self.borderBottom makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        
        make.bottom.equalTo(self.contentView).offset(0);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.height.equalTo(6);
        
    }];
    
    self.borderBottom.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.00];
    
    [self.author makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.oneImageView).offset(-10);
        
        make.bottom.equalTo(self.oneImageView).offset(0);
        
        make.height.equalTo(40);
        
        make.width.equalTo(80);
        
    }];
    
    [self.author setFont:[UIFont systemFontOfSize:12]];
    
    self.author.textColor = [UIColor whiteColor];
    
    self.author.textAlignment = 2;
    
}


-(void)setModel:(LTMainListModel *)model
{
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:model.title];
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        
        style.headIndent = 10;
        
        // 首行缩进
        style.firstLineHeadIndent = 10;
        
        // 行间距
//        style.lineSpacing = 5;
        
        // 设置字体颜色
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, str.length)];
        
        [str addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, str.length)];
        
        self.title.attributedText = str;
        
        [self.title setFont:[UIFont systemFontOfSize:16]];
        
        self.author.text = model.auther_name;
        
        
        
        NSURL *url = [NSURL URLWithString:model.thumbnail_mpic];
        
        [self.oneImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placehoderYellow"]];
        
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
