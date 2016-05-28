//
//  LTSwitchCell.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/28.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTSwitchCell.h"

#import "LTBaseView.h"

@implementation LTSwitchCell

- (void)dealloc
{
    [_switchBtn release];
    
    [_title release];
    
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
        
        
        
        self.borderBottom = [[UILabel alloc] init];
        
        [self.contentView addSubview:_borderBottom];
        [_borderBottom release];
        
        
        self.switchBtn = [[UISwitch alloc] init];
        
        [self.contentView addSubview:_switchBtn];
        [_switchBtn release];
        
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.title makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    
    
    [self.borderBottom makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.bottom.equalTo(self.contentView).offset(0);
        
        make.height.equalTo(1);
        
    }];
    
    self.borderBottom.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    
    [self.switchBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-30);
        
        make.top.equalTo(self.contentView).offset(16);
        
        make.width.equalTo(38);
        
        make.height.equalTo(32);
        
    }];

    
    
}

-(void)setString:(NSString *)string
{
    if (_string != string) {
        
        _string = string;
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        
        style.firstLineHeadIndent = 16;
        
        [str addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, str.length)];
        
        self.title.attributedText = str;
        
        [self.title setFont:[UIFont systemFontOfSize:14]];
        
        
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
