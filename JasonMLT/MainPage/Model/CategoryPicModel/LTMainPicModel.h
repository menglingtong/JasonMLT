//
//  LTMainPicModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/23.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

@interface LTMainPicModel : LTBaseModel


@property (nonatomic, copy) NSString *thumbnail_mpic;

/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 网络请求连接 */
@property (nonatomic, copy) NSString *weburl;

@property (nonatomic, copy) NSString *thumbnail_pic;

@property (nonatomic, copy) NSString *full_url;

/** 图片尺寸 */
@property (nonatomic, copy) NSString *thumbnail_picsize;

/** 文章来源 */
@property (nonatomic, copy) NSString *auther_name;

@end
