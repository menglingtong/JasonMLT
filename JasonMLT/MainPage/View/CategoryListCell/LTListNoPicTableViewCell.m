//
//  LTListNoPicTableViewCell.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/24.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTListNoPicTableViewCell.h"
#import "LTBaseView.h"

@implementation LTListNoPicTableViewCell

- (void)dealloc
{
    [_title release];
    [_author release];
    
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
        
        self.borderBottom = [[UILabel alloc] init];
        
        [self.contentView addSubview:_borderBottom];
        [_borderBottom release];
        
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.title makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.top.equalTo(self.contentView).offset(38.5);
        
        make.height.equalTo(30);
        
    }];
    
    self.title.textColor = [UIColor colorWithRed:0.23 green:0.23 blue:0.23 alpha:1.00];
    
    [self.author makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        
        make.top.equalTo(self.title.bottom).offset(5);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.height.equalTo(10);
        
    }];
    
    [self.author setFont:[UIFont systemFontOfSize:12]];
    self.author.textColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.00];
    
    
    [self.borderBottom makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        
        make.bottom.equalTo(self.contentView).offset(0);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.height.equalTo(6);
        
    }];
    
    self.borderBottom.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.00];
    
}

-(void)setModel:(LTMainListModel *)model
{
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
        
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
