//
//  LTTopicEntranceListModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/26.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

@interface LTTopicEntranceListModel : LTBaseModel

/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 跳转链接 */
@property (nonatomic, copy) NSString *weburl;

/** 只是为了格式好看 */
@property (nonatomic, copy) NSString *full_url;

/** 文章来源 */
@property (nonatomic, copy) NSString *auther_name;

/** 图片 */
@property (nonatomic, retain) NSArray *media;

/** media model */
@property (nonatomic, retain) NSMutableArray *mediaModelArray;

@end
