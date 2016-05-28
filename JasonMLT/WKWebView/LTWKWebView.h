//
//  LTWKWebView.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/27.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseViewController.h"

@interface LTWKWebView : LTBaseViewController

@property (nonatomic, copy) NSString *url;

/** bottom backBar */
@property (nonatomic, retain) UIView *backBar;

/** back button */
@property (nonatomic, retain) UIButton *backBtn;

/** refresh button */
@property (nonatomic, retain) UIButton *refreshBtn;

@end
