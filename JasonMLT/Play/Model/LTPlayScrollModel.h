//
//  LTPlayScrollModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/21.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"
#import "LTScrollWebModel.h"


@interface LTPlayScrollModel : LTBaseModel

@property (nonatomic, copy) NSString *title;

/** 滚动视图图片链接地址 */
@property (nonatomic, copy) NSString *promotion_img;

/** 滚动视图点击跳转链接地址 */
@property (nonatomic, retain) NSDictionary *web;


@property (nonatomic, retain) NSMutableArray *webModelArray;

@end


