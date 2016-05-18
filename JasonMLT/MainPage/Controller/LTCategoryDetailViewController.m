//
//  LTCategoryDetailViewController.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/17.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTCategoryDetailViewController.h"
#import "LTBaseView.h"

@interface LTCategoryDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation LTCategoryDetailViewController

-(void)dealloc
{
    [_categoryDetailTableView release];
    [_categoryDetailDataSourceArray release];
    [_model release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化自定义搜索框
    self.searchBar = [[LTSearchBar alloc] initWithFrame:CGRectMake(0, 0, 300, 31) cornerRadius:15 borderWidth:0 backgroundColor:[UIColor whiteColor] borderColor:[UIColor whiteColor]];
    
    // 将自定义搜索框放置到导航控制器的 titleView
    self.navigationItem.titleView = self.searchBar;
    
    // 修改返回按钮样式
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backWhite"] style:UIBarButtonItemStylePlain target:self action:@selector(popToFrontPage)];
}


-(void)loadView
{
    [super loadView];
    
    // 初始化详细栏目数据源数组
    self.categoryDetailDataSourceArray = [[NSArray alloc] init];
    
    self.categoryDetailDataSourceArray = self.model.category;
    
    self.categoryDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStylePlain];
    
    self.categoryDetailTableView.delegate = self;
    self.categoryDetailTableView.dataSource = self;
    
    [self.view addSubview:_categoryDetailTableView];
    [_categoryDetailTableView release];
    
    // 初始化cell
    [self.categoryDetailTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"categoryDetailCell"];
    
    
}

#pragma mark 返回方法
- (void) popToFrontPage
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 
#pragma mark <UITableViewDelegate, UITableViewDataSource>

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoryDetailDataSourceArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryDetailCell"];
    
    cell.textLabel.text = [[self.categoryDetailDataSourceArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
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
