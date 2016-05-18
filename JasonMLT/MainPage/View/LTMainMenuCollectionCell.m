//
//  LTMainMenuCollectionCell.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/14.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTMainMenuCollectionCell.h"

#define MAS_SHORTHAND // 1.对于约束参数可以省去 "mas_"
#define MAS_SHORTHAND_GLOBALS // 2.对于默认的约束参数自动装箱
#import "Masonry.h" // 3.宏必须添加在头文件前面

@implementation LTMainMenuCollectionCell

-(void)dealloc
{
    [_isEditImage release];
    
    [_menuNameLabel release];
    
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.isEditImage = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_isEditImage];
        [_isEditImage release];
        
        
        // 菜单名字label的初始化
        self.menuNameLabel = [[UILabel alloc] init];
        
        
        
        [self.contentView addSubview:_menuNameLabel];
        [_menuNameLabel release];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 为编辑模式下右上角的图标布局
    [self.isEditImage makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(10);
        
        make.right.equalTo(self.contentView).offset(-10);
        
        make.width.equalTo(20);
        
        make.height.equalTo(20);
        
        
    }];
    
    // 为菜单中的名字label布局
    [self.menuNameLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.contentView).offset(-20);
        
        make.left.equalTo(self.contentView).offset(10);
        
        make.right.equalTo(self.contentView).offset(-10);
        
        make.height.equalTo(30);
        
        
    }];
    
    self.menuNameLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.73 blue:0.61 alpha:1.00];
    self.menuNameLabel.textColor = [UIColor whiteColor];
    self.menuNameLabel.textAlignment = 1;
    
}

@end
