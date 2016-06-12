//
//  LTPlayCell.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/21.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTPlayCell.h"
#import "LTBaseView.h"

#import "LTPicModel.h"

#import <UIImageView+WebCache.h>

@implementation LTPlayCell

-(void)dealloc
{
    [_LTtitleLabel release];
    [_LTImageView release];
    [_LTcontentLabel release];
    [_grayView release];
    [_indexPath release];
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        // 初始化imageview
        self.LTImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_LTImageView];
        [_LTImageView release];
        
        // 初始化灰色遮罩层
        self.grayView = [[UIView alloc] init];
        
        [self.contentView addSubview:_grayView];
        [_grayView release];
        
        // 初始化图片上的大字
        self.LTtitleLabel  = [[UILabel alloc] init];
        
        [self.contentView addSubview:_LTtitleLabel];
        [_LTtitleLabel release];
        
        // 初始化图片上小字
        self.LTcontentLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:_LTcontentLabel];
        [_LTcontentLabel release];
        
        
        
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 布局图片
    [self.LTImageView makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        
        make.top.equalTo(self.contentView).offset(0);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.bottom.equalTo(self.contentView).offset(-3);
        
    }];
    
//    self.LTImageView.backgroundColor = [UIColor colorWithRed:0.18 green:0.65 blue:0.15 alpha:1.00];
    
    // 布局图片遮罩层
    [self.grayView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        
        make.top.equalTo(self.contentView).offset(0);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.bottom.equalTo(self.contentView).offset(-3);
        
    }];
    
    self.grayView.backgroundColor = [UIColor colorWithRed:0.01 green:0.01 blue:0.01 alpha:0.50];
    
    [self.LTtitleLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(20);
        make.bottom.equalTo(self.contentView).multipliedBy(0.5);
        make.right.equalTo(self.contentView).offset(- 20);
        make.height.equalTo(20);
        
    }];
    
    self.LTtitleLabel.textAlignment = 1;
    self.LTtitleLabel.textColor = [UIColor whiteColor];
    
    [self.LTcontentLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(20);
        make.top.equalTo(self.LTtitleLabel.bottom).offset(5);
        make.right.equalTo(self.contentView).offset(- 20);
        make.height.equalTo(15);
        
    }];
    
    self.LTcontentLabel.textAlignment = 1;
    self.LTcontentLabel.textColor = [UIColor whiteColor];
    [self.LTcontentLabel setFont:[UIFont systemFontOfSize:12]];
    
    
    
    
}

#pragma mark 重写model的set方法
-(void)setModel:(LTPlayModel *)model
{
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
        
        
        self.LTtitleLabel.text = model.title;
        
        self.LTcontentLabel.text = model.content;
        
        LTPicModel *picModel = [model.picModelArray firstObject];
        
        [self.LTImageView sd_setImageWithURL:[NSURL URLWithString:picModel.url] placeholderImage:[UIImage imageNamed:@"placehoderYellow"]];
        
        
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
