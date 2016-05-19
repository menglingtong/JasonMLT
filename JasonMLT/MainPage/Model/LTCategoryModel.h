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
@property (nonatomic, assign) BOOL is_Selected;

/** 父类名字 */
@property (nonatomic, copy) NSString *parentTitle;

@end
