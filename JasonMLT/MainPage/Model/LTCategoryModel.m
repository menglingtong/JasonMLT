//
//  LTCategoryModel.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/17.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTCategoryModel.h"

@implementation LTCategoryModel

-(void)dealloc
{
    [_categoryTitle release];
    [_category release];
    [super dealloc];
}

@end
