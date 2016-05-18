//
//  LTUISearchBar+LTSetSearchBar.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/17.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTUISearchBar+LTSetSearchBar.h"

#pragma mark -
#pragma mark SearchBar 类目方法的实现

@implementation UISearchBar (LTSetSearchBar)

- (void)LTSetTextFont:(UIFont *)font {
    if (IS_IOS9) {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].font = font;
    }else {
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setFont:font];
    }
}

- (void)LTSetTextColor:(UIColor *)textColor {
    if (IS_IOS9) {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].textColor = textColor;
    }else {
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:textColor];
    }
}

- (void)LTSetCancelButtonTitle:(NSString *)title {
    if (IS_IOS9) {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:title];
    }else {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:title];
    }
}

@end
