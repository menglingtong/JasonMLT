//
//  LTHotTrebleImageCell.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/20.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTHotTrebleImageCell.h"

@implementation LTHotTrebleImageCell

-(void)dealloc
{
    [_borderBottomThin release];
    [_borderBottomThin2 release];
    [_borderBottom release];
    [_titleLabel release];
    
    [_leftImageView release];
    [_rightTopImageView release];
    [_rightBottomImageView release];
    
    [_model release];
    [_autherNameLabel release];
    [_dateLabel release];
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        // 初始化下边线细线1
        self.borderBottomThin = [[UILabel alloc] init];
        
        [self.contentView addSubview:_borderBottomThin];
        [_borderBottomThin release];
        
        // j初始化下边线细线2
        self.borderBottomThin2 = [[UILabel alloc] init];
        
        [self.contentView addSubview:_borderBottomThin2];
        [_borderBottomThin2 release];
        
        // 初始化下边线粗
        self.borderBottom = [[UILabel alloc] init];
        
        [self.contentView addSubview:_borderBottom];
        [_borderBottom release];
        
        // 初始化左图
        self.leftImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_leftImageView];
        [_leftImageView release];
        
        // 初始化右上
        self.rightTopImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_rightTopImageView];
        [_rightTopImageView release];
        
        // 初始化右下
        self.rightBottomImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_rightBottomImageView];
        [_rightBottomImageView release];
        
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
    
    // 布局title
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(13);
        
        make.top.equalTo(self.contentView).offset(0);
        
        make.right.equalTo(self.contentView).offset(-13);
        
        make.height.equalTo(44.5);
        
    }];
    
    
    self.titleLabel.textColor = [UIColor colorWithRed:0.17 green:0.12 blue:0.03 alpha:1.00];
    
    [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    self.titleLabel.numberOfLines = 0;
    
    
    
    // 布局下边线细线
    [self.borderBottomThin makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.bottom.equalTo(self.contentView).offset(0);
        
        make.height.equalTo(0.5);
        
    }];
    self.borderBottomThin.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.00];
    
    // 布局下边线粗
    [self.borderBottom makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.bottom.equalTo(self.borderBottomThin.top).offset(0);
        
        make.height.equalTo(5);
        
    }];
    
    self.borderBottom.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    
    // 布局下边线细线2
    [self.borderBottomThin2 makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.bottom.equalTo(self.borderBottom.top).offset(0);
        
        make.height.equalTo(0.5);
        
    }];
    self.borderBottomThin2.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.00];
    
    // 布局左图片
    [self.leftImageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLabel.bottom).offset(0);
        
        make.left.equalTo(self.contentView).offset(13);
        
        make.height.equalTo(197);
        
        make.width.equalTo(210);
        
    }];
    
    
    self.leftImageView.backgroundColor = [UIColor colorWithRed:0.53 green:0.85 blue:0.45 alpha:1.00];
    
    // 布局右上
    [self.rightTopImageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLabel.bottom).offset(0);
        
        make.left.equalTo(self.leftImageView.right).offset(3);
        
        make.right.equalTo(self.contentView).offset(-13);
        
        make.height.equalTo(97);
        
    }];
    
    
    self.rightTopImageView.backgroundColor = [UIColor colorWithRed:0.53 green:0.85 blue:0.45 alpha:1.00];
    
    // 布局右下
    [self.rightBottomImageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.rightTopImageView.bottom).offset(3);
        
        make.left.equalTo(self.leftImageView.right).offset(3);
        
        make.right.equalTo(self.contentView).offset(-13);
        
        make.height.equalTo(97);
        
    }];
    
    self.rightBottomImageView.backgroundColor = [UIColor colorWithRed:0.53 green:0.85 blue:0.45 alpha:1.00];
    
    
    
    // 布局 autherLabel
    [self.autherNameLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(13);
        
        make.top.equalTo(self.leftImageView.bottom).offset(9);
        
        make.bottom.equalTo(self.borderBottomThin).offset(-11);
        
    }];
    

    
    self.autherNameLabel.textColor = [UIColor colorWithRed:0.17 green:0.12 blue:0.03 alpha:1.00];
    [self.autherNameLabel setFont:[UIFont systemFontOfSize:12]];
    
    
    // 布局 dateLabel
    [self.dateLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.autherNameLabel.right).offset(20);
        
        make.top.equalTo(self.leftImageView.bottom).offset(9);
        
        make.bottom.equalTo(self.borderBottomThin).offset(-11);
        
    }];
    

    
    self.dateLabel.textColor = [UIColor colorWithRed:0.17 green:0.12 blue:0.03 alpha:1.00];
    [self.dateLabel setFont:[UIFont systemFontOfSize:12]];
    

    
    
}

-(void)setAutherNameLabel:(UILabel *)autherNameLabel
{
    
    if (_autherNameLabel != autherNameLabel) {
        
        [_autherNameLabel release];
        
        _autherNameLabel = [autherNameLabel retain];
        
        [self.autherNameLabel sizeToFit];
        
    }
    
}

-(void)setDateLabel:(UILabel *)dateLabel
{
    
    if (_dateLabel != dateLabel) {
        
        [_dateLabel release];
        
        _dateLabel = [dateLabel retain];
        
        [self.dateLabel sizeToFit];
        
    }
    
}

-(void)setModel:(LTHotModel *)model
{
    
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
        
        
        self.titleLabel.text = model.title;
        
        self.dateLabel.text = model.updateTime;
        
        self.autherNameLabel.text = model.source;
        
        
        
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
