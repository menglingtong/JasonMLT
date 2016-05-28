//
//  LTMyCollectCell.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/28.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTMyCollectCell.h"

#import "LTBaseView.h"

@implementation LTMyCollectCell

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
        
        
        self.arrow = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_arrow];
        [_arrow release];
        
        self.tempCachLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:_tempCachLabel];
        [_tempCachLabel release];
        
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
    
    
    [self.arrow makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-12);
        
        make.top.equalTo(self.contentView).offset(16);
        
        make.width.equalTo(32);
        
        make.height.equalTo(32);
        
    }];
    
    self.arrow.image = [UIImage imageNamed:@"arrowGray"];
    
    [self.tempCachLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.arrow.left).offset(- 10);
        
        make.top.equalTo(self.contentView).offset(0);
        
        make.bottom.equalTo(self.contentView).offset(0);
        
        make.width.equalTo(100);
        
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


-(void)setTempCacheStr:(NSString *)tempCacheStr
{
    if (_tempCacheStr != tempCacheStr) {
        
        _tempCacheStr = tempCacheStr;
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:tempCacheStr];
        
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.00] range:NSMakeRange(0, str.length)];
        
        self.tempCachLabel.attributedText = str;
        
        [self.tempCachLabel setFont:[UIFont systemFontOfSize:12]];
        
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
