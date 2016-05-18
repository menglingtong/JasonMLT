//
//  LTCategoryDetailTableViewCell.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/17.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTCategoryDetailTableViewCell.h"

@implementation LTCategoryDetailTableViewCell

-(void)dealloc
{
    [_separatorLine release];
    [_titleLable release];
    [_pick release];
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.isSelected = NO;
        
        self.separatorLine = [[UILabel alloc] init];
        
        [self.contentView addSubview:_separatorLine];
        [_separatorLine release];
        
        
        self.titleLable = [[UILabel alloc] init];
        
        [self.contentView addSubview:_titleLable];
        [_titleLable release];
        
        
        self.pick = [[UIImageView alloc] init];
        
        self.pick.image = [UIImage imageNamed:@"addGray"];
        
        [self.contentView addSubview:_pick];
        [_pick release];
        
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [self.titleLable makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(25);
        make.top.equalTo(self.contentView).offset(20);
        make.height.equalTo(20);
        make.width.equalTo(75);
        
    }];
    
    self.titleLable.textColor = [UIColor colorWithRed:0.23 green:0.23 blue:0.23 alpha:1.00];
    [self.titleLable setFont:[UIFont systemFontOfSize:14]];
    
    
    [self.pick makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-13);
        make.top.equalTo(self.contentView).offset(16);
        make.width.equalTo(32);
        make.height.equalTo(32);
        
    }];
    
    [self.separatorLine makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.height.equalTo(1);
    }];
    
    self.separatorLine.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    
}

-(void)setIsSelected:(BOOL)isSelected
{
    
    if (_isSelected != isSelected) {
        
        _isSelected = isSelected;
        
        if (_isSelected) {
            
            self.pick.image = [UIImage imageNamed:@"checkGray"];
            
        }
        else
        {
            
            self.pick.image = [UIImage imageNamed:@"addGray"];
            
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
