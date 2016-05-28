//
//  LTPlayViewController.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/11.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTPlayViewController.h"

#import "LTPlayCell.h"

#import "LTDisPlayCell.h"

#import "LTNetTool.h"

#import "LTSectionModel.h"

#import "LTPlayScrollModel.h"

#import "LTArticleModel.h"

#import "LTTwoDisplayModel.h"

#import "LTBannerModel.h"

#import <UIImageView+WebCache.h>

// 滚动视图
#import <SDCycleScrollView.h>

#import <MJRefresh.h>

#import "LTWKWebView.h"



@interface LTPlayViewController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy) NSString *next_url;

@end

@implementation LTPlayViewController

-(void)dealloc
{
    
    _playTableView.delegate = nil;
    _playTableView.dataSource = nil;
    [_playTableView release];

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
    
    self.playScrollDataSourceArray = [[NSMutableArray alloc] init];
    
    self.playTowDataSourceArray = [[NSMutableArray alloc] init];
    
    // 赋值api链接
    self.playApiUrl = @"http://wl.myzaker.com/?_appid=iphone&_v=6.5.2&_version=6.54&c=columns&city=%E5%A4%A7%E8%BF%9E";
//    self.playApiUrl = @"http://wl.myzaker.com/?_appid=iphone&_v=6.5.2&_version=6.54&c=columns&city=大连";
    
    
    // 请求数据
    [self askForData:_playApiUrl];
    
    // 初始化玩乐页面的tableview
    self.playTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStyleGrouped];
    
    // 签代理
    self.playTableView.delegate = self;
    self.playTableView.dataSource = self;
    
    // 消除分割线
    self.playTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.playTableView.showsVerticalScrollIndicator = NO;
    
    
    
    // 将tableview添加到主视图上
    [self.view addSubview:_playTableView];
    [_playTableView release];
    
    // 注册cell
    [self.playTableView registerClass:[LTPlayCell class] forCellReuseIdentifier:@"playCell"];
    
    
    // 下拉刷新
//    self.playTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//        [self askForData:self.next_url];
//        
//    }];
    
    // 上拉加载
    self.playTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self askForData:self.next_url];
        
    }];
    
    
}

#pragma mark push新页面的时候,隐藏tabBar
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
//    self.navigationController.navigationBar.hidden = NO;
    
    self.hidesBottomBarWhenPushed = YES;
    
}

#pragma mark 返回的时候显示tabBar
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
//    self.navigationController.navigationBar.hidden = YES;
    
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark -
#pragma mark 请求数据
- (void) askForData:(NSString *)url
{
    
    [LTNetTool GetNetWithUrl:url body:nil header:nil response:LTJSON success:^(id result) {
        
        self.next_url = [[[result objectForKey:@"data"] objectForKey:@"info"] objectForKey:@"next_url"];
        
        // 解析 columns 页面主要内容及 section头的内容
        for (NSDictionary *dic in [[result objectForKey:@"data"] objectForKey:@"columns"]) {
            
            LTSectionModel *model = [[LTSectionModel alloc] initWithDic:dic];
            
            [self.playDataSourceArray addObject:model];
            [model release];
            
        }
        
        
        if (url == _playApiUrl) {
            
            // 解析 promote 滚动视图的内容
            for (NSDictionary *dic in [[result objectForKey:@"data"] objectForKey:@"promote"]) {
                
                LTPlayScrollModel *model = [[LTPlayScrollModel alloc] initWithDic:dic];
                
                [self.playScrollDataSourceArray addObject:model];
                [model release];
                
            }
            
            // 解析 display 滚动视图下两个展示图片
            for (NSDictionary *dic in [[result objectForKey:@"data"] objectForKey:@"display"]) {
                
                LTTwoDisplayModel *model = [[LTTwoDisplayModel alloc] initWithDic:dic];
                
                [self.playTowDataSourceArray addObject:model];
                [model release];
                
            }
            
            [self setPlayScrollView];
            
        }
        
        [self.playTableView.mj_header endRefreshing];
        
        [self.playTableView.mj_footer endRefreshing];
        
        [self.playTableView reloadData];
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

#pragma mark -
#pragma mark 设置滚动视图
- (void) setPlayScrollView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 249)];
    
    // 初始化一个存储图片地址的数组
    NSMutableArray *imageUrlArr = [[NSMutableArray alloc] init];
    
    for (LTPlayScrollModel *model in self.playScrollDataSourceArray) {
        
        [imageUrlArr addObject:model.promotion_img];
        
    }
    
    // 初始化一个第三方滚动视图
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 160) delegate:self placeholderImage:[UIImage imageNamed:@"placehoderYellow"]];
    
    
    cycleScrollView.imageURLStringsGroup = [imageUrlArr retain];
    [imageUrlArr release];
    
    cycleScrollView.autoScroll = YES;
    
    cycleScrollView.showPageControl = YES;
    
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    
    [headerView addSubview:cycleScrollView];
    
    
    UICollectionViewFlowLayout *displayLayout = [[UICollectionViewFlowLayout alloc] init];
    
    displayLayout.itemSize = CGSizeMake((ScreenWidth - 21) / 2.0, 75);
    
    displayLayout.sectionInset = UIEdgeInsetsMake(7, 7, 7, 7);
    
    displayLayout.minimumLineSpacing = 7;
    displayLayout.minimumInteritemSpacing = 7;
    
    UICollectionView *displayCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, cycleScrollView.frame.size.height, ScreenWidth, headerView.frame.size.height - cycleScrollView.frame.size.height) collectionViewLayout:displayLayout];
    
    displayCollection.contentSize = CGSizeMake(ScreenWidth, headerView.frame.size.height - cycleScrollView.frame.size.height);
    
    displayCollection.scrollEnabled = NO;
    
    displayCollection.delegate = self;
    displayCollection.dataSource = self;
    
    displayCollection.backgroundColor = [UIColor whiteColor];
    
    // 注册cell
    [displayCollection registerClass:[LTDisPlayCell class] forCellWithReuseIdentifier:@"displayCell"];
    
    [headerView addSubview:displayCollection];
    [displayCollection release];
    
    self.playTableView.tableHeaderView = [headerView retain];
    [headerView release];
    
}

#pragma mark - 
#pragma mark <UICollectionViewDelegate, UICollectionViewDataSource>
#pragma mark 返回collection cell 个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.playTowDataSourceArray.count;
}

#pragma mark cell 初始化
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LTDisPlayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"displayCell" forIndexPath:indexPath];
    
    LTTwoDisplayModel *model = [self.playTowDataSourceArray objectAtIndex:indexPath.item];
    
    cell.model = model;
    
    cell.backgroundColor = [UIColor colorWithRed:0.53 green:0.85 blue:0.45 alpha:1.00];
    
    return cell;
}

#pragma mark -
#pragma mark <UITableViewDelegate, UITableViewDataSource>
#pragma mark 返回section的个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.playDataSourceArray.count;
}
#pragma mark 返回每个section footer的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark 返回每个section header的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 33;
}

#pragma mark 返回每个section header的内容
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    LTSectionModel *model = [self.playDataSourceArray objectAtIndex:section];
    
    LTBannerModel *bannerModel = [model.bannerModelArray firstObject];
    
    NSURL *m_url = [NSURL URLWithString:bannerModel.m_url];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 33)];
    
    [imageView sd_setImageWithURL:m_url];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 33)];
    
    [view addSubview:imageView];
    
    return view;
}

#pragma mark 返回cell的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 取出每个分区
    LTSectionModel *model = [self.playDataSourceArray objectAtIndex:section];
    
    // 返回每个分区所包含的行数
    return model.playModelArray.count;
}

#pragma mark 初始化cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTPlayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"playCell"];
    
    LTSectionModel *model = [self.playDataSourceArray objectAtIndex:indexPath.section];
    
    LTPlayModel *playModel = [model.playModelArray objectAtIndex:indexPath.row];
    
    cell.indexPath = indexPath;
    
    cell.model = playModel;
    
    // 取消默认点击效果(背景变灰)
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark 返回每个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 202;
}

#pragma mark cell的点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTSectionModel *model = [self.playDataSourceArray objectAtIndex:indexPath.section];
    
    LTPlayModel *playModel = [model.playModelArray objectAtIndex:indexPath.row];
    
    LTArticleModel *articleModel = [playModel.articleModelArray firstObject];
    
    LTWKWebView *webView = [[LTWKWebView alloc] init];
    
    webView.url = articleModel.weburl;
    
    [self.navigationController pushViewController:webView animated:YES];
    
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
