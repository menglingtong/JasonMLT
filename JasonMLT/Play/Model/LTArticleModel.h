//
//  LTArticleModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/21.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

@interface LTArticleModel : LTBaseModel

/** 网页跳转链接 */
@property (nonatomic, copy) NSString *weburl;

@property (nonatomic, copy) NSString *full_url;

@end
