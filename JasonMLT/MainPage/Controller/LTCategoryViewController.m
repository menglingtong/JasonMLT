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

#import <MMTweenFunction.h>
#import <MMTweenAnimation.h>

@interface LTCategoryViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, LTSearchBarDelegate>

@property (nonatomic, retain) UIView *searchView;

@property (nonatomic, retain) MMTweenAnimation *animStart;

@property (nonatomic, retain) MMTweenAnimation *animEnd;

@property (nonatomic, retain) UITableView *searchResultTableView;

@property (nonatomic, retain) NSMutableArray *searchResultDataSourceArray;

@end

@implementation LTCategoryViewController

-(void)dealloc
{
    _categoryTableView.delegate = nil;
    _categoryTableView.dataSource = nil;
    
    [_categoryTableView release];
    
    [_categoryDataSource release];
    
    [_willAddDataSource release];
    
    _searchBar.LTDelegate = nil;
    [_searchBar release];
    
    [_animStart pop_removeAllAnimations];
    [_animEnd pop_removeAllAnimations];
    
//    [_categoryModel release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化自定义搜索框
    self.searchBar = [[LTSearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 75, 31) cornerRadius:15 borderWidth:0 backgroundColor:[UIColor whiteColor] borderColor:[UIColor whiteColor]];
    
    self.searchBar.LTDelegate = self;
    
    // 将自定义搜索框放置到导航控制器的 titleView
    self.navigationItem.titleView = self.searchBar;
    
    // 修改返回按钮样式
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backWhite"] style:UIBarButtonItemStylePlain target:self action:@selector(popToFrontPage)];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self; // 自定义返回按钮后，边缘返回手势失效，使边缘手势生效
    
}

-(void)loadView
{
    [super loadView];
    
    // 初始化栏目数据源数组
    self.categoryDataSource = [[NSMutableArray alloc] init];
    
    self.searchResultDataSourceArray = [[NSMutableArray alloc] init];
    
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
    
    self.searchResultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    
    self.searchResultTableView.delegate = self;
    self.searchResultTableView.dataSource = self;
    
    [self.searchResultTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"searchResultCell"];
    
    [self.searchView addSubview:_searchResultTableView];
    [_searchResultTableView release];
    
    
}

#pragma mark LTSearchBarDelegate
-(void)searchResultView
{
    
    NSDictionary *barColorDic = @{EAThemeNormal : [UIColor colorWithRed:0.99 green:0.76 blue:0.18 alpha:1.00],  // 正常模式颜色
                                  EAThemeBlack  : [UIColor colorWithRed:0.08 green:0.08 blue:0.08 alpha:1.00],  // 黑色模式
                                  EAThemeRed    : [UIColor colorWithRed:0.91 green:0.31 blue:0.25 alpha:1.00],  // 红色模式
                                  EAThemeOrange : [UIColor colorWithRed:0.91 green:0.50 blue:0.15 alpha:1.00],  // 橘黄色模式
                                  EAThemeBlue   : [UIColor colorWithRed:0.38 green:0.69 blue:0.89 alpha:1.00],  // 蓝色模式
                                  EAThemeGreen  : [UIColor colorWithRed:0.11 green:0.73 blue:0.61 alpha:1.00]}; // 绿色模式
    
    __weak __typeof(&*self)LT = self;
    
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(0, -ScreenHeight + 64, ScreenWidth, ScreenHeight - 64)];
    
    [self.view addSubview:_searchView];
    [_searchView release];
    
    @ea_weakify(self);
    // 设置主题切换时的回调方法
    [self.searchView ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
        
        @ea_strongify(self);
        
        currentView.backgroundColor = barColorDic[currentThemeIdentifier];
        
    }];
    
//    self.searchView.backgroundColor = [UIColor colorWithRed:0.99 green:0.76 blue:0.18 alpha:1.00];
    
    // 初始化动画对象
    self.animStart = [MMTweenAnimation animation];
    
    // 设置动画类型
    self.animStart.functionType = MMTweenFunctionBounce;
    
    self.animStart.easingType = MMTweenEasingOut;
    
    // 设置动画时间
    self.animStart.duration = 2.0f;
    
    // 设置起始位置
    self.animStart.fromValue = @[@(self.searchView.center.y)];
    
    // 设置结束位置
    self.animStart.toValue = @[@(self.searchView.center.y + (ScreenHeight - 64))];
    
    [self.searchView pop_addAnimation:self.animStart forKey:@"enter"];
    
    
    self.animStart.animationBlock =  ^(double c,double d,NSArray *v,id target,MMTweenAnimation *animation)
    {
        
        double value = [v[0] doubleValue];
        
        LT.searchView.center = CGPointMake(LT.searchView.center.x, value);
        
    };
    
}

#pragma mark LTSearchBarDelegate
-(void)cancelSearchResultView
{
    __weak __typeof(&*self)LT = self;
    
    self.animEnd = [MMTweenAnimation animation];
    
    self.animEnd.functionType = MMTweenFunctionCirc;
    
    self.animEnd.easingType = MMTweenEasingIn;
    
    self.animEnd.duration = 1.0f;
    
    self.animEnd.fromValue = @[@(self.searchView.center.y)];
    
    self.animEnd.toValue = @[@(self.searchView.center.y - (ScreenHeight + 64))];
    
    [self.searchView pop_addAnimation:self.animEnd forKey:@"exit"];
    
    self.animEnd.animationBlock = ^(double c,double d,NSArray *v,id target,MMTweenAnimation *animation)
    {
        
        double value = [v[0] doubleValue];
        
        LT.searchView.center = CGPointMake(LT.searchView.center.x, value);
        
    };

    
}

#pragma mark LTSearchBarDelegate
-(void)didBeginSearchWithCondition:(NSString *)condition
{
    
    
    [self searchingWithCondition:condition];
    
    
    
}

-(void)searchingWithCondition:(NSString *)condition
{
    
    // 获取本地document路径
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/JasonMLT.sqlite"];
    
    // 创建数据库路径
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    if ([db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"select * from categoryDetail where title = '%@'", condition];
        
        [db executeStatements:sql withResultBlock:^int(NSDictionary *resultsDictionary) {
            
            LTCategoryModel *model = [[LTCategoryModel alloc] initWithDic:resultsDictionary];
            
            [self.searchResultDataSourceArray addObject:model];
            
            return 0;
        }];
        
    }
    [db close];
    
    [self.searchResultTableView reloadData];
    
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
    if (tableView == self.categoryTableView) {
        
        
        LTCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell" forIndexPath:indexPath];
        
        LTCategoryModel *model = [self.categoryDataSource objectAtIndex:indexPath.row];
        
        cell.model = model;
        
        // 取消点击变灰
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    
    if (tableView == self.searchResultTableView) {
        
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchResultCell"];
        
        cell.textLabel.textColor = [UIColor whiteColor];
        
        LTCategoryModel *model = [self.categoryDataSource objectAtIndex:indexPath.row];
        
        cell.textLabel.text = model.title;
        
        return cell;
    }
    
    return nil;
    
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
