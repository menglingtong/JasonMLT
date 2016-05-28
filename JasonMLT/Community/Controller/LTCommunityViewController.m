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

@interface LTCommunityViewController ()<UITableViewDelegate, UITableViewDataSource>

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
    
}

#pragma mark - 
#pragma mark <UITableViewDelegate, UITableViewDataSource>
#pragma mark 返回cell的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == 0) {
        
        LTMyCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCollectCell"];
        
        cell.string = @"我的收藏";
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    if (indexPath.row == 3) {
        
        LTMyCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCollectCell"];
        
        cell.string = @"清除缓存";
        
        cell.tempCacheStr = @"当前缓存";
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    
    if (indexPath.row == 1) {
        
        LTSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switchCell"];
        
        cell.string = @"夜间模式";
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    if (indexPath.row == 2) {
        
        LTSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switchCell"];
        
        cell.string = @"彩色图标";
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
