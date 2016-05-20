//
//  LTHotNewsViewController.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/11.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTHotNewsViewController.h"
#import "LTHotTableViewCell.h"

#import "LTHotModel.h"
#import "LTThumbnailMediasModel.h"

#import "LTNetTool.h"

@interface LTHotNewsViewController ()<UITableViewDelegate, UITableViewDataSource>

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
    
    [self askForData:@"http://hotphone.myzaker.com/daily_hot_new.php?_udid=EFF67A40-E743-4850-978E-0E96FC82A7B2&_uid=11483531"];
    
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
    
}

#pragma mark -
#pragma mark 请求数据
-(void)askForData:(NSString *)urlStr
{
    
    
    // 调用网络请求方法开始请求数据
    [LTNetTool GetNetWithUrl:urlStr body:nil header:nil response:LTJSON success:^(id result) {
        
        NSArray *tempArr = [[result objectForKey:@"data"] objectForKey:@"articles"];
        
        for (NSDictionary *tempDic in tempArr) {
            
            LTHotModel *model = [[LTHotModel alloc] initWithDic:tempDic];
            
            [self.hotDataSourceArray addObject:model];
            [model release];
            
        }
        
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
    LTHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotCell"];
    
    LTHotModel *model = [self.hotDataSourceArray objectAtIndex:indexPath.row];
    
    cell.model = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark 返回每个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 117;
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
