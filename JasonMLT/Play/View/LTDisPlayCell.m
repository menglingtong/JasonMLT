//
//  LTDisPlayCell.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/22.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTDisPlayCell.h"
#import "LTBaseView.h"
#import <UIImageView+WebCache.h>

#import "LTDisplayPicModel.h"

@implementation LTDisPlayCell

- (void)dealloc
{
    [_displayImageView release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.displayImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_displayImageView];
        [_displayImageView release];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.displayImageView makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(0);
        
        make.top.equalTo(0);
        
        make.right.equalTo(0);
        
        make.bottom.equalTo(0);
        
    }];
    
}

-(void)setModel:(LTTwoDisplayModel *)model
{
    if (_model != model) {
        
        [_model release];
        _model = [model retain];
        
        LTDisplayPicModel *picModel = [model.picModelArray firstObject];
        
        NSURL *url = [NSURL URLWithString:picModel.m_url];
        
        [self.displayImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placehoderYellow"]];
        
    }
    

}

@end
