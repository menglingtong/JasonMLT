//
//  LTEntranceOnePicCell.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/26.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTEntranceOnePicCell.h"

#import "LTBaseView.h"

#import <UIImageView+WebCache.h>

#import "LTTopicEntranceMediaModel.h"

@implementation LTEntranceOnePicCell

- (void)dealloc
{
    [_title release];
    [_author release];
    [_picImageView release];
    [_model release];
    [_borderBottom release];
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.title = [[UILabel alloc] init];
        
        [self.contentView addSubview:_title];
        [_title release];
        
        self.author = [[UILabel alloc] init];
        
        [self.contentView addSubview:_author];
        [_author release];
        
        self.picImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_picImageView];
        [_picImageView release];
        
        self.borderBottom = [[UILabel alloc] init];
        
        [self.contentView addSubview:_borderBottom];
        [_borderBottom release];
        
        
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.picImageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(110);
        
        make.top.equalTo(self.contentView).equalTo(12);
        
        make.right.equalTo(self.contentView).equalTo(-12);
        
        make.bottom.equalTo(self.contentView).equalTo(-12);
        
    }];
    
    [self.title makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).equalTo(0);
        
        make.right.equalTo(self.picImageView.left).equalTo(-24);
        
        make.bottom.equalTo(self.contentView).equalTo(0);
        
        make.left.equalTo(self.contentView).equalTo(0);
        
    }];
    
    
    [self.author makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(13);
        
        make.bottom.equalTo(self.contentView).offset(-14);
        
        make.width.equalTo(100);
        
        make.height.equalTo(30);
        
    }];
    
    [self.author setFont:[UIFont systemFontOfSize:12]];
    
    self.author.textColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.00];
    
    [self.borderBottom makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        
        make.bottom.equalTo(self.contentView).offset(0);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.height.equalTo(1);
    }];
    
    self.borderBottom.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    
    
}

-(void)setModel:(LTTopicEntranceListModel *)model
{
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:model.title];
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        
        style.firstLineHeadIndent = 13;
        
        [str addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, str.length)];
        
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.00] range:NSMakeRange(0, str.length)];
        
        self.title.attributedText = str;
        
        self.author.text = model.auther_name;
        
        LTTopicEntranceMediaModel *mediaModel = [model.mediaModelArray firstObject];
        
        NSURL *url = [NSURL URLWithString:mediaModel.url];
        
        [self.picImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placehoderYellow"]];
        
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
