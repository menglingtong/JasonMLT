//
//  LTBaseViewController.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/11.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseViewController.h"



@interface LTBaseViewController ()

@end

@implementation LTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.99 green:0.76 blue:0.18 alpha:1.00];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationItem setTitle:@"MLT"];
    
    NSDictionary *barColorDic = @{EAThemeNormal : [UIColor colorWithRed:0.99 green:0.76 blue:0.18 alpha:1.00],  // 正常模式颜色
                                  EAThemeBlack  : [UIColor colorWithRed:0.08 green:0.08 blue:0.08 alpha:1.00],  // 黑色模式
                                  EAThemeRed    : [UIColor colorWithRed:0.91 green:0.31 blue:0.25 alpha:1.00],  // 红色模式
                                  EAThemeOrange : [UIColor colorWithRed:0.91 green:0.50 blue:0.15 alpha:1.00],  // 橘黄色模式
                                  EAThemeBlue   : [UIColor colorWithRed:0.38 green:0.69 blue:0.89 alpha:1.00],  // 蓝色模式
                                  EAThemeGreen  : [UIColor colorWithRed:0.11 green:0.73 blue:0.61 alpha:1.00]}; // 绿色模式
    
    [self.navigationController.navigationBar ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
        
        UINavigationBar *bar = (UINavigationBar *)currentView;
        
        bar.barStyle = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? UIBarStyleBlack : UIBarStyleBlack;
        
        bar.barTintColor = barColorDic[currentThemeIdentifier];
        
    }];
    
    
    @ea_weakify(self);
    // 设置主题切换时的回调方法
    [self.view ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
       
        @ea_strongify(self);
        
        currentView.backgroundColor = self.tabBarController.tabBar.barTintColor;
        
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
