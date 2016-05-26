//
//  LTTopicArticleCell.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/25.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTTopicArticleCell.h"

#import "LTBaseView.h"

@implementation LTTopicArticleCell

- (void)dealloc
{
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
        
        
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.title makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 0, 1, 0));
        
    }];
    
    [self.borderBottom makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.title.bottom).offset(0);
        
        make.left.equalTo(self.contentView).offset(0);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.bottom.equalTo(self.contentView).offset(0);
        
    }];
    
    self.borderBottom.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    
}

-(void)setModel:(LTTopicArticleModel *)model
{
    
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:model.title];
        
        NSMutableParagraphStyle *styple = [[NSMutableParagraphStyle alloc] init];
        
        styple.firstLineHeadIndent = 13;
        
        [str addAttribute:NSParagraphStyleAttributeName value:styple range:NSMakeRange(0, str.length)];
        
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.23 green:0.23 blue:0.23 alpha:1.00] range:NSMakeRange(0, str.length)];
        
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
