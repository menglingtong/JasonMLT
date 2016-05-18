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

/** category */
@property (nonatomic, retain) NSArray *category;

@end
