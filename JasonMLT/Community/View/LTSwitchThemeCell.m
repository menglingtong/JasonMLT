//
//  LTSwitchThemeCell.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/29.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTSwitchThemeCell.h"

#import "LTBaseView.h"

#import "EATheme.h"

@implementation LTSwitchThemeCell


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
        
        self.normalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.normalBtn addTarget:self action:@selector(didClicekedNormalBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_normalBtn];
        [_normalBtn release];
        
        
        
        self.blackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.blackBtn addTarget:self action:@selector(didClicekedBlackBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_blackBtn];
        [_blackBtn release];
        
        
        
        self.redBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.redBtn addTarget:self action:@selector(didClicekedRedBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_redBtn];
        [_redBtn release];
        
        
        
        self.orangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.orangeBtn addTarget:self action:@selector(didClicekedOrangeBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_orangeBtn];
        [_orangeBtn release];
        
        
        
        
        self.blueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.blueBtn addTarget:self action:@selector(didClicekedBlueBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_blueBtn];
        [_blueBtn release];
        
        
        
        self.greenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.greenBtn addTarget:self action:@selector(didClicekedGreenBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_greenBtn];
        [_greenBtn release];
        
        
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
    
    
    [self.greenBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-18);
        
        make.top.equalTo(self.contentView).offset(20);
        
        make.width.equalTo(ScreenWidth / 12.5);
        
        make.height.equalTo(ScreenWidth / 18.75);
        
    }];
    
    self.greenBtn.backgroundColor = [UIColor colorWithRed:0.11 green:0.73 blue:0.61 alpha:1.00];
    
    
    
    [self.blueBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.greenBtn.left).offset(-12);
        
        make.top.equalTo(self.contentView).offset(20);
        
        make.width.equalTo(ScreenWidth / 12.5);
        
        make.height.equalTo(ScreenWidth / 18.75);
        
    }];
    
    self.blueBtn.backgroundColor = [UIColor colorWithRed:0.38 green:0.69 blue:0.89 alpha:1.00];
    
    
    [self.orangeBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.blueBtn.left).offset(-12);
        
        make.top.equalTo(self.contentView).offset(20);
        
        make.width.equalTo(ScreenWidth / 12.5);
        
        make.height.equalTo(ScreenWidth / 18.75);
        
    }];
    
    self.orangeBtn.backgroundColor = [UIColor colorWithRed:0.91 green:0.50 blue:0.15 alpha:1.00];
    
    
    [self.redBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.orangeBtn.left).offset(-12);
        
        make.top.equalTo(self.contentView).offset(20);
        
        make.width.equalTo(ScreenWidth / 12.5);
        
        make.height.equalTo(ScreenWidth / 18.75);
        
    }];
    
    self.redBtn.backgroundColor = [UIColor colorWithRed:0.91 green:0.31 blue:0.25 alpha:1.00];
    
    
    [self.blackBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.redBtn.left).offset(-12);
        
        make.top.equalTo(self.contentView).offset(20);
        
        make.width.equalTo(ScreenWidth / 12.5);
        
        make.height.equalTo(ScreenWidth / 18.75);
        
    }];
    
    self.blackBtn.backgroundColor = [UIColor blackColor];
    
    
    [self.normalBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.blackBtn.left).offset(-12);
        
        make.top.equalTo(self.contentView).offset(20);
        
        make.width.equalTo(ScreenWidth / 12.5);
        
        make.height.equalTo(ScreenWidth / 18.75);
        
    }];
    
    self.normalBtn.backgroundColor = [UIColor colorWithRed:0.99 green:0.76 blue:0.18 alpha:1.00];
    
    
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

#pragma mark - 切换主题按钮
- (void) didClicekedNormalBtn:(UIButton *)sender
{
    
    [[EAThemeManager shareManager] displayThemeContentsWithThemeIdentifier:EAThemeNormal];
    
}

- (void) didClicekedBlackBtn:(UIButton *)sender
{
    
    [[EAThemeManager shareManager] displayThemeContentsWithThemeIdentifier:EAThemeBlack];
    
}

- (void) didClicekedRedBtn:(UIButton *)sender
{
    
    [[EAThemeManager shareManager] displayThemeContentsWithThemeIdentifier:EAThemeRed];
    
}

- (void) didClicekedOrangeBtn:(UIButton *)sender
{
    
    [[EAThemeManager shareManager] displayThemeContentsWithThemeIdentifier:EAThemeOrange];
    
}

- (void) didClicekedBlueBtn:(UIButton *)sender
{
    
    [[EAThemeManager shareManager] displayThemeContentsWithThemeIdentifier:EAThemeBlue];
    
}

- (void) didClicekedGreenBtn:(UIButton *)sender
{
    
    [[EAThemeManager shareManager] displayThemeContentsWithThemeIdentifier:EAThemeGreen];
    
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
