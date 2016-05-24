//
//  LTDisplayWebModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/21.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

@interface LTDisplayWebModel : LTBaseModel

@property (nonatomic, copy) NSString *title;

/** 滚动视图下面两个展示的跳转链接 */
@property (nonatomic, copy) NSString *api_url;

@end
