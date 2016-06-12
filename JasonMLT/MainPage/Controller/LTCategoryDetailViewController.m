//
//  LTCategoryDetailViewController.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/17.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTCategoryDetailViewController.h"
#import "LTBaseView.h"
#import "LTCategoryDetailTableViewCell.h"

#import <FMDB.h>

@interface LTCategoryDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation LTCategoryDetailViewController

-(void)dealloc
{
    _categoryDetailTableView.delegate = nil;
    _categoryDetailTableView.dataSource = nil;
    [_categoryDetailTableView release];
    [_categoryDetailDataSourceArray release];
    [_model release];
    [_tempArray release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化自定义搜索框
//    self.searchBar = [[LTSearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 75, 31) cornerRadius:15 borderWidth:0 backgroundColor:[UIColor whiteColor] borderColor:[UIColor whiteColor]];
    
    // 将自定义搜索框放置到导航控制器的 titleView
//    self.navigationItem.titleView = self.searchBar;
    
    // 修改返回按钮样式
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backWhite"] style:UIBarButtonItemStylePlain target:self action:@selector(popToFrontPage)];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self; // 自定义返回按钮后，边缘返回手势失效，使边缘手势生效
}



-(void)loadView
{
    [super loadView];
    
    // 初始化详细栏目数据源数组
    self.categoryDetailDataSourceArray = [[NSMutableArray alloc] init];
    
    // 将临时数组初始化
    self.tempArray = [[NSMutableArray alloc] init];
    
    // 将临时字典初始化
    self.tempDic = [[NSMutableDictionary alloc] init];
    
    
    // 获取本地document路径
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/JasonMLT.sqlite"];
    
    // 创建数据库路径
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    if ([db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"select * from categoryDetail where parentTitle = '%@'", self.model.categoryTitle];
        
        [db executeStatements:sql withResultBlock:^int(NSDictionary *resultsDictionary) {
            
            LTCategoryModel *model = [[LTCategoryModel alloc] initWithDic:resultsDictionary];
            
            [self.categoryDetailDataSourceArray addObject:model];
            
            return 0;
        }];
        
    }
    [db close];
    
    self.categoryDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStylePlain];
    
    self.categoryDetailTableView.delegate = self;
    self.categoryDetailTableView.dataSource = self;
    
    self.categoryDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_categoryDetailTableView];
    [_categoryDetailTableView release];
    
    // 初始化cell
    [self.categoryDetailTableView registerClass:[LTCategoryDetailTableViewCell class] forCellReuseIdentifier:@"categoryDetailCell"];
    
    
}

#pragma mark 返回方法
- (void) popToFrontPage
{
    
    // 获取本地document路径
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/JasonMLT.sqlite"];
    
    // 创建数据库路径
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    if ([db open]) {
        
        NSArray *arr = [self.tempDic allKeys];
        
        for (NSString *str in arr) {
            
            NSString *sql = [NSString stringWithFormat:@"update categoryDetail set is_Selected = %d, indexPath = 1000 where title = '%@'",[[self.tempDic objectForKey:str] intValue]  ,str];
            
            [db executeUpdate:sql];
            
        }
        
    }
    [db close];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 
#pragma mark <UITableViewDelegate, UITableViewDataSource>

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoryDetailDataSourceArray.count;
}

#pragma mark 每个cell的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTCategoryDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryDetailCell"];
    
    LTCategoryModel *model = [self.categoryDetailDataSourceArray objectAtIndex:indexPath.row];
    
    cell.titleLable.text = model.title;
    
    cell.isSelected = model.is_Selected;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark 返回cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark cell的点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LTCategoryDetailTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    if (cell.isSelected) {
        
        cell.isSelected = NO;
        
        cell.pick.image = [UIImage imageNamed:@"addGray"];
        
        NSString *str = [NSString stringWithFormat:@"%d", cell.isSelected];
        
        // 开始接收修改的属性
        [self.tempDic setValue:str forKey:cell.titleLable.text];
        
    }
    else
    {
        cell.isSelected = YES;
        
        NSString *str = [NSString stringWithFormat:@"%d", cell.isSelected];
        
        // 开始接收修改的属性
        [self.tempDic setValue:str forKey:cell.titleLable.text];
        
    }
    
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
