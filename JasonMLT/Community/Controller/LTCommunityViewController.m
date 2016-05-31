//
//  LTCommunityViewController.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/11.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTCommunityViewController.h"

#import "LTMyCollectCell.h"

#import "LTSwitchCell.h"

#import "LTSwitchThemeCell.h"

#import <SDImageCache.h>

@interface LTCommunityViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *cacheImage;

@end

@implementation LTCommunityViewController

- (void)dealloc
{
    [_mainTableView release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)loadView
{
    [super loadView];
    
    
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49 - 64) style:UITableViewStyleGrouped];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_mainTableView];
    [_mainTableView release];
    
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.mainTableView registerClass:[LTMyCollectCell class] forCellReuseIdentifier:@"myCollectCell"];
    
    [self.mainTableView registerClass:[LTSwitchCell class] forCellReuseIdentifier:@"switchCell"];
    
    [self.mainTableView registerClass:[LTSwitchThemeCell class] forCellReuseIdentifier:@"switchThemeCell"];
    
    
    @ea_weakify(self);
    // 设置主题切换时的回调方法
    [self.mainTableView ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
        
        @ea_strongify(self);
        
        if([currentThemeIdentifier isEqualToString:EAThemeBlack])
        {
            
            currentView.backgroundColor = VIEW_BACKGROUND_DARK;
            
        }
        else
        {
            
            currentView.backgroundColor = VIEW_BACKGROUND_NORMAL;
            
        }
        
    }];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.mainTableView reloadData];
}

#pragma mark -
#pragma mark <UITableViewDelegate, UITableViewDataSource>
#pragma mark 返回cell的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
//    if (indexPath.row == 0) {
//        
//        LTMyCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCollectCell"];
//        
//        cell.string = @"我的收藏";
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        @ea_weakify(self);
//        // 设置主题切换时的回调方法
//        [cell ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
//            
//            @ea_strongify(self);
//            
//            if([currentThemeIdentifier isEqualToString:EAThemeBlack])
//            {
//                
//                cell.backgroundColor = CELL_BACKGROUND_DARK;
//                cell.title.textColor = TEXT_COLOR_DARK;
//                
//            }
//            else
//            {
//                
//                cell.backgroundColor = CELL_BACKGROUND_NORMAL;
//                cell.title.textColor = TEXT_COLOR_NORMAL;
//                
//            }
//            
//        }];
//        
//        
//        return cell;
//    }
    
//    if (indexPath.row == 1) {
//        
//        LTSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switchCell"];
//        
//        cell.string = @"夜间模式";
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        @ea_weakify(self);
//        // 设置主题切换时的回调方法
//        [cell ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
//            
//            @ea_strongify(self);
//            
//            if([currentThemeIdentifier isEqualToString:EAThemeBlack])
//            {
//                
//                cell.backgroundColor = CELL_BACKGROUND_DARK;
//                cell.title.textColor = TEXT_COLOR_DARK;
//                
//            }
//            else
//            {
//                
//                cell.backgroundColor = CELL_BACKGROUND_NORMAL;
//                cell.title.textColor = TEXT_COLOR_NORMAL;
//                
//            }
//            
//        }];
//        
//        return cell;
//    }
//    
//    if (indexPath.row == 2) {
//        
//        LTSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switchCell"];
//        
//        cell.string = @"彩色图标";
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        @ea_weakify(self);
//        // 设置主题切换时的回调方法
//        [cell ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
//            
//            @ea_strongify(self);
//            
//            if([currentThemeIdentifier isEqualToString:EAThemeBlack])
//            {
//                
//                cell.backgroundColor = CELL_BACKGROUND_DARK;
//                cell.title.textColor = TEXT_COLOR_DARK;
//                
//            }
//            else
//            {
//                
//                cell.backgroundColor = CELL_BACKGROUND_NORMAL;
//                cell.title.textColor = TEXT_COLOR_NORMAL;
//                
//            }
//            
//        }];
//        
//        return cell;
//        
//    }
    
    if (indexPath.row == 0) {
        
        LTSwitchThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switchThemeCell"];
        
        cell.string = @"切换主题";
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        @ea_weakify(self);
        // 设置主题切换时的回调方法
        [cell ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
            
            @ea_strongify(self);
            
            if([currentThemeIdentifier isEqualToString:EAThemeBlack])
            {
                
                cell.backgroundColor = CELL_BACKGROUND_DARK;
                cell.title.textColor = TEXT_COLOR_DARK;
                
            }
            else
            {
                
                cell.backgroundColor = CELL_BACKGROUND_NORMAL;
                cell.title.textColor = TEXT_COLOR_NORMAL;
                
            }
            
        }];
        
        return cell;
    }
    
    if (indexPath.row == 1) {
        
        LTMyCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCollectCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        @ea_weakify(self);
        // 设置主题切换时的回调方法
        [cell ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
            
            @ea_strongify(self);
            
            if([currentThemeIdentifier isEqualToString:EAThemeBlack])
            {
                
                cell.backgroundColor = CELL_BACKGROUND_DARK;
                cell.title.textColor = TEXT_COLOR_DARK;
                
            }
            else
            {
                
                cell.backgroundColor = CELL_BACKGROUND_NORMAL;
                cell.title.textColor = TEXT_COLOR_NORMAL;
                
            }
            
        }];
        
        cell.string = @"清除缓存";
        
        [self imageCacheSize:2];
        
        cell.tempCacheStr = [NSString stringWithFormat:@"当前缓存 %@", self.cacheImage];
        
        
        
        
        return cell;
        
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
        LTMyCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCollectCell"];
        
        NSString *str = [NSString stringWithFormat:@"清除缓存 %@", self.cacheImage];
        
        UIAlertController *clearCache = [UIAlertController alertControllerWithTitle:@"清除缓存" message:str preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self clearCache];
            
            [self imageCacheSize:0];
            
            cell.tempCacheStr = [NSString stringWithFormat:@"当前缓存 %d", 0];
            
        }];
        
        [clearCache addAction:confirm];
        [clearCache addAction:cancel];
        
        [self presentViewController:clearCache animated:YES completion:nil];
        

        
    }
}

- (void)clearCache
{
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    
    [self.mainTableView reloadData];
}

- (void)imageCacheSize:(NSInteger) accuracy
{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
        CGFloat imageSize = ([[SDImageCache sharedImageCache] getSize] / 1024.0f) / 1024.0f;
        
        NSString *imageSizeString = [NSString stringWithFormat:@"%f",imageSize];
        
        NSRange dotRange = [imageSizeString rangeOfString:@"."];
        
        NSInteger lastPosition = dotRange.location + accuracy;
        
        imageSizeString = [imageSizeString substringToIndex:lastPosition];
        
//        dispatch_async(dispatch_get_main_queue(), ^{
        
            self.cacheImage = [NSString stringWithFormat:@"%@ M",imageSizeString];
            
//        });
        
//    });
    
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
