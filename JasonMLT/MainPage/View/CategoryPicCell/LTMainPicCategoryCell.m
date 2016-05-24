//
//  LTMainPicCategoryCell.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/23.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTMainPicCategoryCell.h"

@implementation LTMainPicCategoryCell

- (void)dealloc
{
    [_borderBottom release];
    
    [_picImageView release];
    
    [_title release];
    
    [_author release];
    
    [super dealloc];
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.borderBottom = [[UILabel alloc] init];
        
        [self.contentView addSubview:_borderBottom];
        [_borderBottom release];
        
        
        self.picImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_picImageView];
        [_picImageView release];
        
        
        
        self.title = [[UILabel alloc] init];
        
        [self.contentView addSubview:_title];
        [_title release];
        
        self.author = [[UILabel alloc] init];
        
        [self.title addSubview:_author];
        [_author release];
        
    }
    
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.borderBottom makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.bottom.equalTo(self.contentView).offset(0);
        
        make.height.equalTo(8);
        
        
    }];
    self.borderBottom.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    
    [self.picImageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.top.equalTo(self.contentView).offset(0);
        
        make.bottom.equalTo(self.title.top).offset(0);
        
    }];
    
//    [self.picImageView sizeToFit];
    
    
    [self.title makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12.5);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.height.equalTo(88);
        
        make.bottom.equalTo(self.borderBottom.top).offset(0);
        
    }];
    
    self.title.textColor = [UIColor colorWithRed:0.57 green:0.57 blue:0.57 alpha:1.00];
    
    [self.title setFont:[UIFont systemFontOfSize:14]];
    
    [self.author makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12.5);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.height.equalTo(16);
        
        make.bottom.equalTo(self.borderBottom.top).offset(-18);
        
    }];
    
    self.author.textColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.00];
    
    [self.author setFont:[UIFont systemFontOfSize:12]];
    
    
}

-(void)setModel:(LTMainPicModel *)model
{
    
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
        
        NSURL *url = [NSURL URLWithString:model.thumbnail_pic];
        
        [self.picImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placehoderYellow"]];
        
        self.title.text = model.title;
        
        self.author.text = model.auther_name;
        
        
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
