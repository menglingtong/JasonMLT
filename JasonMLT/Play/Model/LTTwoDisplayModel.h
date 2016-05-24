//
//  LTTwoDisplayModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/21.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

@interface LTTwoDisplayModel : LTBaseModel

/** 滚动视图下面两个展示的图片 */
@property (nonatomic, retain) NSDictionary *pic;

@property (nonatomic, retain) NSMutableArray *picModelArray;

/** 滚动视图下面两个展示的跳转链接 */
@property (nonatomic, retain) NSDictionary *block_info;

@property (nonatomic, retain) NSMutableArray *webModelArray;

@end
