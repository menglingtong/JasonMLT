//
//  LTCategoryModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/17.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

@interface LTCategoryModel : LTBaseModel

/** categoryTitle 栏目名称 */
@property (nonatomic, copy) NSString *categoryTitle;

/** categoryDetial title */
@property (nonatomic, copy) NSString *title;

/** 接口链接 */
@property (nonatomic, copy) NSString *api_url;

/** 是否被选中 */
@property (nonatomic, assign) bool is_Selected;

/** 父类名字 */
@property (nonatomic, copy) NSString *parentTitle;

/** 图片名 */
@property (nonatomic, copy) NSString *pic;

/** 十六进制颜色 */
@property (nonatomic, copy) NSString *color;

@end
