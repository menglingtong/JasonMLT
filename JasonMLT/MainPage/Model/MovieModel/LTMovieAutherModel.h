//
//  LTMovieAutherModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/27.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

@interface LTMovieAutherModel : LTBaseModel

/** 用户名 */
@property (nonatomic, copy) NSString *name;

/** 用户id */
@property (nonatomic, copy) NSString *uid;

/** 用户头像 */
@property (nonatomic, copy) NSString *icon;


@end
