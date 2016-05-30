//
//  LTSwitchThemeCell.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/29.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTSwitchThemeCell : UITableViewCell

@property (nonatomic, retain) UILabel *title;

@property (nonatomic, retain) UILabel *borderBottom;

@property (nonatomic, copy) NSString *string;

/** 正常模式(黄色模式) */
@property (nonatomic, retain) UIButton *normalBtn;

/** 黑色模式 */
@property (nonatomic, retain) UIButton *blackBtn;

/** 红色模式 */
@property (nonatomic, retain) UIButton *redBtn;

/** 橘黄色模式 */
@property (nonatomic, retain) UIButton *orangeBtn;

/** 蓝色模式 */
@property (nonatomic, retain) UIButton *blueBtn;

/** 绿色模式 */
@property (nonatomic, retain) UIButton *greenBtn;

@end
