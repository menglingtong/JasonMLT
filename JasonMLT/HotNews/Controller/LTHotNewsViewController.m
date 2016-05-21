//
//  LTHotNewsViewController.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/11.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTHotNewsViewController.h"
#import "LTHotTableViewCell.h"
#import "LTHotTrebleImageCell.h"

#import "LTHotModel.h"

#import "LTNetTool.h"

#import <MJRefresh.h>

@interface LTHotNewsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *url;

@end

@implementation LTHotNewsViewController

-(void)dealloc
{
    _hotTableView.delegate = nil;
    _hotTableView.dataSource = nil;
    [_hotTableView reloadData];
    
    [_hotDataSourceArray release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.url = @"http://api.irecommend.ifeng.com/read.php?uid=864260027969516";
    
    [self askForData:self.url Action:@"pullUp"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"HOT NEWS";
    
}

-(void)loadView
{
    [super loadView];
    
    // 初始化数据源数组
    self.hotDataSourceArray = [[NSMutableArray alloc] init];
    
    // 初始化tableview
    self.hotTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStylePlain];
    
    self.hotTableView.delegate = self;
    self.hotTableView.dataSource = self;
    
    // 将默认的分割线去掉
    self.hotTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_hotTableView];
    [_hotTableView release];
    
    // 注册cell
    [self.hotTableView registerClass:[LTHotTableViewCell class] forCellReuseIdentifier:@"hotCell"];
    [self.hotTableView registerClass:[LTHotTrebleImageCell class] forCellReuseIdentifier:@"hotTrebleImageCell"];
    
    
    // 下拉刷新
    self.hotTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self askForData:self.url Action:@"pullDown"];
        
    }];
    
    // 上拉加载
    self.hotTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self askForData:self.url Action:@"pullUp"];
        
    }];
    
    
}

#pragma mark -
#pragma mark 请求数据
-(void)askForData:(NSString *)urlString Action:(NSString *)action
{

    // 调用网络请求方法开始请求数据
    [LTNetTool GetNetWithUrl:urlString body:nil header:nil response:LTJSON success:^(id result) {
        
        NSArray *tempArr = [result objectForKey:@"item"];
        
        for (NSDictionary *tempDic in tempArr) {
            
            LTHotModel *model = [[LTHotModel alloc] initWithDic:tempDic];
            
            if ([action isEqualToString:@"pullDown"]) {
                
                // 下拉刷新时,把新请求的数据放到数组最前面
                [self.hotDataSourceArray insertObject:model atIndex:0];
                
            }
            else if ([action isEqualToString:@"pullUp"])
            {
                
                // 上拉加载时,把新请求的数据放到数组最后面
                [self.hotDataSourceArray addObject:model];
                
            }
            
            
            [model release];
            
        }
        
//        self.hotDataSourceArray = [[self.hotDataSourceArray reverseObjectEnumerator] allObjects];
        
        [self.hotTableView.mj_header endRefreshing];
        
        [self.hotTableView.mj_footer endRefreshing];
        
        [self.hotTableView reloadData];
        
    } failure:^(NSError *error) {
        
        NSLog(@"请求失败");
        
    }];
    
}

#pragma mark -
#pragma mark hotTableView的代理方法 <UITableViewDelegate, UITableViewDataSource> 
#pragma mark 返回cell的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hotDataSourceArray.count;
}

#pragma mark 初始化cell 重用方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTHotModel *model = [self.hotDataSourceArray objectAtIndex:indexPath.row];
    
    if ([model.type isEqualToString:@"doc"]) {
        
        LTHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotCell"];
        
        cell.model = model;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    else if ([model.type isEqualToString:@"slide"])
    {
        
        LTHotTrebleImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotTrebleImageCell"];
        
        cell.model = model;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    
    
    return nil;
}

#pragma mark 返回每个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTHotModel *model = [self.hotDataSourceArray objectAtIndex:indexPath.row];
    
    if ([model.type isEqualToString:@"doc"]) {
        
        return 113;
        
    }
    else if ([model.type isEqualToString:@"slide"])
    {
        
        return 283;
        
    }

    return 0;
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



