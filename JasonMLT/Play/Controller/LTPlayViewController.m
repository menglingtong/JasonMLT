//
//  LTPlayViewController.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/11.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTPlayViewController.h"
#import "LTPlayCell.h"
#import "LTNetTool.h"

#import "LTSectionModel.h"


@interface LTPlayViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation LTPlayViewController

-(void)dealloc
{
    
    _playTableView.delegate = nil;
    _playTableView.dataSource = nil;
    [_playTableView release];
    
    [_scrollImage release];
    [_playDataSourceArray release];
    
    [super dealloc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Play";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

-(void)loadView
{
    [super loadView];
    
    // 初始化数据源数组
    self.playDataSourceArray = [[NSMutableArray alloc] init];
    
    // 赋值api链接
    self.playApiUrl = @"http://wl.myzaker.com/?_appid=iphone&_v=6.5.2&_version=6.54&c=columns&city=%E5%A4%A7%E8%BF%9E";
    
    // 初始化玩乐页面的tableview
    self.playTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStylePlain];
    
    // 签代理
    self.playTableView.delegate = self;
    self.playTableView.dataSource = self;
    
    // 消除分割线
    self.playTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 将tableview添加到主视图上
    [self.view addSubview:_playTableView];
    [_playTableView release];
    
    // 注册cell
    [self.playTableView registerClass:[LTPlayCell class] forCellReuseIdentifier:@"playCell"];
    
}

#pragma mark -
#pragma mark 请求数据
- (void) askForData
{
    
    [LTNetTool GetNetWithUrl:self.playApiUrl body:nil header:nil response:LTJSON success:^(id result) {
        
        // 解析 columns 页面主要内容及 section头的内容
        for (NSDictionary *dic in [[result objectForKey:@"data"] objectForKey:@"columns"]) {
            
            LTSectionModel *model = [[LTSectionModel alloc] initWithDic:dic];
            
            [self.playDataSourceArray addObject:model];
            [model release];
            
        }
        
        [self.playTableView reloadData];
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
}


#pragma mark -
#pragma mark <UITableViewDelegate, UITableViewDataSource>
#pragma mark 返回cell的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

#pragma mark 初始化cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTPlayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"playCell"];
    
    // 取消默认点击效果(背景变灰)
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 返回每个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 202;
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
