//
//  LTCategoryViewController.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/16.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTCategoryViewController.h"
#import "LTCategoryTableViewCell.h"
#import "LTCategoryDetailViewController.h"

#import <FMDB.h>

@interface LTCategoryViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@end

@implementation LTCategoryViewController

-(void)dealloc
{
    _categoryTableView.delegate = nil;
    _categoryTableView.dataSource = nil;
    
    [_categoryTableView release];
    
    [_categoryDataSource release];
    
    [_willAddDataSource release];
    
    [_searchBar release];
    
//    [_categoryModel release];
    
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
    
    // 初始化栏目数据源数组
    self.categoryDataSource = [[NSMutableArray alloc] init];
    
    // 获取本地document路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *dbPath = [documentPath stringByAppendingString:@"/JasonMLT.sqlite"];
    
    // 创建数据库路径
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    if ([db open]) {
        
        NSString *sql = @"select categoryTitle from category";
        
        [db executeStatements:sql withResultBlock:^int(NSDictionary *resultsDictionary) {
            
            LTCategoryModel *categoryModel = [[LTCategoryModel alloc] initWithDic:resultsDictionary];
            
            [self.categoryDataSource addObject:categoryModel];
            [categoryModel release];
            
            return 0;
        }];
        
    }
    
    
    // 初始化添加的栏目数据源数组
    self.willAddDataSource = [[NSMutableArray alloc] init];
    
    // 初始化tableView
    self.categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    
    self.categoryTableView.showsVerticalScrollIndicator = NO;
    
    // 签代理
    self.categoryTableView.delegate = self;
    self.categoryTableView.dataSource = self;
    
    // 隐藏分割线
    self.categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_categoryTableView];
    [_categoryTableView release];
    
    // 注册cell
    [self.categoryTableView registerClass:[LTCategoryTableViewCell class] forCellReuseIdentifier:@"categoryCell"];
    
    
}

#pragma mark push新页面的时候,隐藏tabBar
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    self.hidesBottomBarWhenPushed = YES;
    
}

#pragma mark 返回方法
- (void) popToFrontPage
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark -
#pragma mark <UITableViewDelegate, UITableViewDataSource>
#pragma mark 返回cell个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoryDataSource.count;
}

#pragma mark 返回每个cell的值
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell" forIndexPath:indexPath];
    
    LTCategoryModel *model = [self.categoryDataSource objectAtIndex:indexPath.row];
    
    cell.model = model;
    
    // 取消点击变灰
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark 返回每个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark cell点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LTCategoryDetailViewController *detailVC = [[LTCategoryDetailViewController alloc] init];
    
    LTCategoryModel *model = [self.categoryDataSource objectAtIndex:indexPath.row];
    
    detailVC.model = model;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
    
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
