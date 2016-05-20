//
//  LTStyle.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/20.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

@interface LTHotStyleModel : LTBaseModel

@property (nonatomic, copy) NSString *tag;

/** 存图片链接的数组 */
@property (nonatomic, strong) NSArray<NSString *> *images;

@property (nonatomic, copy) NSString *type;


@end
