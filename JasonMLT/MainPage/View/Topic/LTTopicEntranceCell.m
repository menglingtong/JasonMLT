//
//  LTTopicEntranceCell.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/25.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTTopicEntranceCell.h"

#import "LTBaseView.h"


@implementation LTTopicEntranceCell

-(void)dealloc
{
    [_title release];
    [_imageArrow release];
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.title = [[UILabel alloc] init];
        
        [self.contentView addSubview:_title];
        [_title release];
        
        
        self.imageArrow = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_imageArrow];
        [_imageArrow release];
        
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.title makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    
    [self.imageArrow makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(30);
        
        make.height.equalTo(30);
        
        make.right.equalTo(self.contentView).offset(-12);
        
        make.top.equalTo(self.contentView).offset(9);
        
    }];
    
    self.imageArrow.image = [UIImage imageNamed:@"arrowGray"];
    
}

-(void)setModel:(LTTopicEntranceModel *)model
{
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:model.title];
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        
        style.firstLineHeadIndent = 13;
        
        [str addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, model.title.length)];
        
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.02 green:0.67 blue:1.00 alpha:1.00] range:NSMakeRange(0, model.title.length)];
        
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
