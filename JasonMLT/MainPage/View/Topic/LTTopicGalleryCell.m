//
//  LTTopicGalleryCell.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/25.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTTopicGalleryCell.h"

#import "LTBaseView.h"

#import <UIImageView+WebCache.h>

@implementation LTTopicGalleryCell

- (void)dealloc
{
    [_galleryImageView release];
    [_title release];
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.galleryImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_galleryImageView];
        [_galleryImageView release];
        
        
        self.title = [[UILabel alloc] init];
        
        [self.contentView addSubview:_title];
        [_title release];
        
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.galleryImageView makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    
    self.galleryImageView.backgroundColor = [UIColor colorWithRed:0.99 green:0.76 blue:0.18 alpha:1.00];
    
    
    [self.title makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        
        make.bottom.equalTo(self.contentView).offset(0);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.height.equalTo(40);
        
    }];
    
    self.title.backgroundColor = [UIColor colorWithRed:0.01 green:0.01 blue:0.01 alpha:0.60];
    
}

-(void)setModel:(LTTopicGalleryModel *)model
{
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
        
        NSURL *url = [NSURL URLWithString:model.promotion_img];
        
        [self.galleryImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placehoderYellow"]];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:model.title];
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        
        style.firstLineHeadIndent = 13;
        
        [str addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, str.length)];
        
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, str.length)];
        
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
