//
//  LTHotTableViewCell.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/19.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTHotTableViewCell.h"

@implementation LTHotTableViewCell

-(void)dealloc
{
    [_borderBottom release];
    [_titleLabel release];
    [_model release];
    [_autherNameLabel release];
    [_dateLabel release];
    [super dealloc];
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        // 初始化下边线
        self.borderBottom = [[UILabel alloc] init];
        
        [self.contentView addSubview:_borderBottom];
        [_borderBottom release];
        
        // 初始化 title
        self.titleLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:_titleLabel];
        [_titleLabel release];
        
        // 初始化 文章作者label
        self.autherNameLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:_autherNameLabel];
        [_autherNameLabel release];
        
        // 初始化 时间label
        self.dateLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:_dateLabel];
        [_dateLabel release];
        
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 布局下边线
    [self.borderBottom makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.bottom.equalTo(self.contentView).offset(0);
        
        make.height.equalTo(8);
        
    }];
    
    self.borderBottom.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    
    // 布局title
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(20);
        
        make.top.equalTo(self.contentView).offset(20);
        
        make.right.equalTo(self.contentView).offset(-20);
        
        make.height.equalTo(40);
        
    }];
    
    self.titleLabel.backgroundColor = [UIColor colorWithRed:0.99 green:0.76 blue:0.18 alpha:1.00];
    
    self.titleLabel.textColor = [UIColor whiteColor];
    
    // 布局 autherLabel
    [self.autherNameLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(20);
        
        make.top.equalTo(self.titleLabel.bottom).offset(16);
        
        make.bottom.equalTo(self.contentView).offset(-20);
        
        make.width.equalTo(40);
        
    }];
    
    self.autherNameLabel.backgroundColor = [UIColor colorWithRed:0.19 green:0.64 blue:0.91 alpha:1.00];
    self.autherNameLabel.textColor = [UIColor whiteColor];
    
    // 布局 dateLabel
    [self.dateLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.autherNameLabel.right).offset(20);
        
        make.top.equalTo(self.titleLabel.bottom).offset(16);
        
        make.bottom.equalTo(self.contentView).offset(-20);
        
        make.width.equalTo(40);
        
    }];
    
    self.dateLabel.backgroundColor = [UIColor colorWithRed:0.83 green:0.26 blue:0.27 alpha:1.00];
    self.dateLabel.textColor = [UIColor whiteColor];
    
    
}

-(void)setModel:(LTHotModel *)model
{
    
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
        
        
        self.titleLabel.text = model.title;
        
        self.dateLabel.text = model.date;
        
        self.autherNameLabel.text = model.auther_name;
        
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
