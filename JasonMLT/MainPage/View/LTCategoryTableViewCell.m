//
//  LTCategoryTableViewCell.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/17.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTCategoryTableViewCell.h"

@implementation LTCategoryTableViewCell

-(void)dealloc
{
    
    [_categoryTitleLabel release];
    [_arrow release];
    [_model release];
    [_separatorLine release];
    
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        // 初始化栏目名称label
        self.categoryTitleLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:_categoryTitleLabel];
        [_categoryTitleLabel release];
        
        
        // 初始化右侧箭头图标
        self.arrow = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_arrow];
        [_arrow release];
        
        // 初始化分割线
        self.separatorLine = [[UILabel alloc] init];
        
        [self.contentView addSubview:_separatorLine];
        [_separatorLine release];
        
        
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.categoryTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(25);
        make.top.equalTo(self.contentView).offset(20);
        make.height.equalTo(20);
        make.width.equalTo(75);
        
    }];
    
    self.categoryTitleLabel.textColor = [UIColor colorWithRed:0.23 green:0.23 blue:0.23 alpha:1.00];
    [self.categoryTitleLabel setFont:[UIFont systemFontOfSize:14]];
    
    
    [self.arrow makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-13);
        make.top.equalTo(self.contentView).offset(16);
        make.width.equalTo(32);
        make.height.equalTo(32);
        
    }];
    
    self.arrow.image = [UIImage imageNamed:@"arrowGray"];
    
    [self.separatorLine makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.height.equalTo(1);
    }];
    
    self.separatorLine.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    
    
}

-(void)setModel:(LTCategoryModel *)model
{
    
    if (_model != model) {
        
        [_model release];
        _model = [model retain];
        
        self.categoryTitleLabel.text = model.categoryTitle;
        
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
