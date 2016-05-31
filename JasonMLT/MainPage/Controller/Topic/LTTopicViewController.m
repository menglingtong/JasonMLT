//
//  LTTopicViewController.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/25.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTTopicViewController.h"

#import "LTNetTool.h"


#import "LTTopicListModel.h"

#import "LTTopicGalleryModel.h"

#import "LTTopicEntranceModel.h"

#import "LTEntranceDetailModel.h"

#import "LTTopicArticleModel.h"


#import "LTTopicGalleryCell.h"

#import "LTTopicArticleCell.h"

#import "LTTopicEntranceCell.h"

#import <MJRefresh.h>

#import "LTTopicEntranceListViewController.h"

@interface LTTopicViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *next_url;

@end

@implementation LTTopicViewController

- (void)dealloc
{
    
    [_dataSourceArray release];
    
    [_mainTableView release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.categoryTitle;
    
//    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self; // 自定义返回按钮后，边缘返回手势失效，使边缘手势生效
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

-(void)loadView
{
    [super loadView];
    
    // 初始化数据源数组
    self.dataSourceArray = [[NSMutableArray alloc] init];
    
    
    // 请求数据
    [self askForDataWithUrlStr:self.url];
    
    // 初始化tableview
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 0, ScreenWidth - 40, ScreenHeight - 64 - 44) style:UITableViewStyleGrouped];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    self.mainTableView.showsVerticalScrollIndicator = NO;
    
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_mainTableView];
    [_mainTableView release];
    
    // 注册 图片cell
    [self.mainTableView registerClass:[LTTopicGalleryCell class] forCellReuseIdentifier:@"galleryCell"];
    
    // 注册 文章cell
    [self.mainTableView registerClass:[LTTopicArticleCell class] forCellReuseIdentifier:@"articleCell"];
    
    // 注册 专题入口cell
    [self.mainTableView registerClass:[LTTopicEntranceCell class] forCellReuseIdentifier:@"entranceCell"];
    
    // 上拉加载
    self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self askForDataWithUrlStr:self.next_url];
        
    }];
    
    
    // 底部导航栏
    self.backBar = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 44 - 64, ScreenWidth, 44)];
    
    self.backBar.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1.00];
    
    UIView *borderTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    
    borderTop.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    
    
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.backBtn.frame = CGRectMake(25, 13.5, 18, 18);
    
    [self.backBtn setImage:[UIImage imageNamed:@"backGray"] forState:UIControlStateNormal];
    
    [self.backBtn addTarget:self action:@selector(didClickedGoBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backBar addSubview:_backBtn];
    
    self.refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.refreshBtn.frame = CGRectMake(ScreenWidth - 25 - 18, 13.5, 18, 18);
    
    [self.refreshBtn setImage:[UIImage imageNamed:@"refreshGray"] forState:UIControlStateNormal];
    
    [self.refreshBtn addTarget:self action:@selector(didClickedRefreshBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backBar addSubview:_refreshBtn];
    
    [self.backBar addSubview:borderTop];
    [borderTop release];
    
    [self.view addSubview:_backBar];
    [_backBar release];
    
    @ea_weakify(self);
    // 设置主题切换时的回调方法
    [self.backBar ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
        
        @ea_strongify(self);
        
        if([currentThemeIdentifier isEqualToString:EAThemeBlack])
        {
            
            currentView.backgroundColor = VIEW_BACKGROUND_DARK;
            
            self.mainTableView.backgroundColor = VIEW_BACKGROUND_DARK;
            
            self.view.backgroundColor = VIEW_BACKGROUND_DARK;
            
        }
        else
        {
            
            currentView.backgroundColor = VIEW_BACKGROUND_NORMAL;
            
            self.mainTableView.backgroundColor = VIEW_BACKGROUND_NORMAL;
            
            self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
            
        }
        
    }];
    
}

#pragma mark push新页面的时候,隐藏tabBar
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    self.hidesBottomBarWhenPushed = YES;
    
}


#pragma mark 请求并解析数据
- (void) askForDataWithUrlStr:(NSString *)url
{
    
    [LTNetTool GetNetWithUrl:url body:nil header:nil response:LTJSON success:^(id result) {
        
        NSDictionary *topicDic = (NSDictionary *)result;
        
        [LTArchiver archiverObject:topicDic ByKey:@"topicDic" WithPath:@"topicDic.plist"];
        
        NSArray *arr = [[result objectForKey:@"data"] objectForKey:@"list"];
        
        self.next_url = [[result objectForKey:@"data"] objectForKey:@"next_url"];
        
        
        for (NSDictionary *dict in arr) {
            
            NSArray *tempArr = [dict objectForKey:@"topic_list"];
            
            for (NSDictionary *tempDic in tempArr) {
                
                LTTopicListModel *model = [[LTTopicListModel alloc] initWithDic:tempDic];
                
                [self.dataSourceArray addObject:model];
                [model release];
                
            }
            
        }
        
        [self.mainTableView.mj_footer endRefreshing];
        
        [self.mainTableView reloadData];
    } failure:^(NSError *error) {
        
        NSDictionary *topicDic = [LTArchiver unarchiverObjectByKey:@"topicDic" WithPath:@"topicDic.plist"];
        
        NSArray *arr = [[topicDic objectForKey:@"data"] objectForKey:@"list"];
        
        self.next_url = [[topicDic objectForKey:@"data"] objectForKey:@"next_url"];
        
        
        for (NSDictionary *dict in arr) {
            
            NSArray *tempArr = [dict objectForKey:@"topic_list"];
            
            for (NSDictionary *tempDic in tempArr) {
                
                LTTopicListModel *model = [[LTTopicListModel alloc] initWithDic:tempDic];
                
                [self.dataSourceArray addObject:model];
                [model release];
                
            }
            
        }
        
        [self.mainTableView.mj_footer endRefreshing];
        
        [self.mainTableView reloadData];
        
    }];
    
}


#pragma mark goBack
- (void) didClickedGoBackBtn:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark refresh
- (void) didClickedRefreshBtn:(UIButton *)btn
{
    [self askForDataWithUrlStr:self.url];
}


#pragma mark -
#pragma mark <UITableViewDelegate, UITableViewDataSource>
#pragma mark 返回section的个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSourceArray.count;
}

#pragma mark 设置section 的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 20;
    
}

#pragma mark  设置section 内容
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    
    sectionHeader.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    
    return sectionHeader;
}

#pragma mark 返回cell的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 每个section恒定为4个
    return 4;
}

#pragma mark 初始化cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 一个 model 是个一section
    LTTopicListModel *model = [self.dataSourceArray objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0) {
        
        LTTopicGalleryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"galleryCell"];
        
        // 获取图片model
        LTTopicGalleryModel *galleryModel = [model.galleryModelArray firstObject];
        
        cell.model = galleryModel;
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 设置主题切换时的回调方法
        [cell ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
            
            if([currentThemeIdentifier isEqualToString:EAThemeBlack])
            {
                
                cell.backgroundColor = CELL_BACKGROUND_DARK;
                
            }
            else
            {
                
                cell.backgroundColor = CELL_BACKGROUND_NORMAL;
                
            }
            
        }];
        
        return cell;
    }
    else if (indexPath.row < 3 && indexPath.row >0)
    {
        LTTopicArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"articleCell"];
        
        // 获取文章model
        LTTopicArticleModel *articleModel = [model.articleModelArray objectAtIndex:indexPath.row - 1];
        
        cell.model = articleModel;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 设置主题切换时的回调方法
        [cell ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
            
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
    else if (indexPath.row == 3)
    {
        
        LTTopicEntranceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"entranceCell"];
        
        LTTopicEntranceModel *entranceModel = [model.entranceModelArray firstObject];
        
        cell.model = entranceModel;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 设置主题切换时的回调方法
        [cell ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
            
            if([currentThemeIdentifier isEqualToString:EAThemeBlack])
            {
                
                cell.backgroundColor = CELL_BACKGROUND_DARK;
                
            }
            else
            {
                
                cell.backgroundColor = CELL_BACKGROUND_NORMAL;
                
            }
            
        }];
        
        return cell;
    }
    
    return nil;
}

#pragma mark 返回cell 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        return 200;
        
    }
    else if (indexPath.row < 3)
    {
        
        return 64.5;
        
    }
    else if (indexPath.row == 3)
    {
        
        return 44.5;
    }
    
    return 0;
}

#pragma mark cell点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 一个 model 是个一section
    LTTopicListModel *model = [self.dataSourceArray objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0) {
        
        
        
    }
    else if (indexPath.row < 3)
    {
        
        
        
    }
    else if (indexPath.row == 3)
    {
        
        LTTopicEntranceListViewController *entranceListVC = [[LTTopicEntranceListViewController alloc] init];
        
        LTTopicEntranceModel *entranceModel = [model.entranceModelArray firstObject];
        
        LTEntranceDetailModel *entranceDetailModel = [entranceModel.entranceDetailModelArray firstObject];
        
        entranceListVC.url = entranceDetailModel.api_url;
        
        entranceListVC.entranceTitle = entranceModel.title;
        
        [self.navigationController pushViewController:entranceListVC animated:YES];
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
