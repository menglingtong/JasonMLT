//
//  AppDelegate.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/11.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "AppDelegate.h"
#import "LTNetTool.h"
#import "LTMainViewController.h"
#import "LTHotNewsViewController.h"
#import "LTPlayViewController.h"
#import "LTCommunityViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.window makeKeyAndVisible];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 设置主页
    LTMainViewController *mainVC = [[LTMainViewController alloc] init];
    
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    mainNav.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Home" image:[[UIImage imageNamed:@"homeGray"] imageWithRenderingMode:1] selectedImage:[[UIImage imageNamed:@"homeYellow"] imageWithRenderingMode:1]] autorelease];
    
    
    // 设置热点页
    LTHotNewsViewController *hotVC = [[LTHotNewsViewController alloc] init];
    
    UINavigationController *hotNav = [[UINavigationController alloc] initWithRootViewController:hotVC];
    
    hotNav.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"HotNews" image:[[UIImage imageNamed:@"exclamatoryGray"] imageWithRenderingMode:1] selectedImage:[[UIImage imageNamed:@"exclamatoryYellow"] imageWithRenderingMode:1]] autorelease];
    
    // 设置玩乐页
    LTPlayViewController *playVC = [[LTPlayViewController alloc] init];
    
    UINavigationController *playNav = [[UINavigationController alloc] initWithRootViewController:playVC];
    
    playVC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Play" image:[[UIImage imageNamed:@"compassGray"] imageWithRenderingMode:1] selectedImage:[[UIImage imageNamed:@"compassYellow"] imageWithRenderingMode:1]] autorelease];
    
    // 设置社区页
    LTCommunityViewController *communityVC = [[LTCommunityViewController alloc] init];
    
    UINavigationController *communityNav = [[UINavigationController alloc] initWithRootViewController:communityVC];
    
    communityVC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Community" image:[[UIImage imageNamed:@"circleGray"] imageWithRenderingMode:1] selectedImage:[[UIImage imageNamed:@"circleYellow"] imageWithRenderingMode:1]] autorelease];
    
    
    
    UITabBarController *tab = [[UITabBarController alloc] init];
    
    tab.viewControllers = @[mainNav, hotNav, playNav, communityNav];
    
    tab.tabBar.tintColor = [UIColor colorWithRed:0.99 green:0.76 blue:0.18 alpha:1.00];
    
    self.window.rootViewController = tab;
    
    [mainVC release];
    [hotVC release];
    [playVC release];
    [communityVC release];
    
    [mainNav release];
    [hotNav release];
    [playNav release];
    [communityNav release];
    
    [tab release];
    
    [_window release];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
