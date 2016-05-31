//
//  LTMovieViewController.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/27.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTMovieViewController.h"

#import "LTNetTool.h"

#import "LTMoviePicCell.h"

@interface LTMovieViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation LTMovieViewController

- (void)dealloc
{
    [_dataSourceArray release];
    [_mainTableView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.categoryTitle;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self; // 自定义返回按钮后，边缘返回手势失效，使边缘手势生效
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
}

-(void)loadView
{
    [super loadView];
    
    self.dataSourceArray = [[NSMutableArray alloc] init];
    
    [self askForDataWithUrlStr:self.url];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStylePlain];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    self.mainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.mainTableView.showsVerticalScrollIndicator = NO;
    
    
    [self.view addSubview:_mainTableView];
    [_mainTableView release];
    
    // 注册cell
    [self.mainTableView registerClass:[LTMoviePicCell class] forCellReuseIdentifier:@"movieCell"];
    
    
    
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
    
    // 设置主题切换时的回调方法
    [self.backBar ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
        
        if([currentThemeIdentifier isEqualToString:EAThemeBlack])
        {
            
            currentView.backgroundColor = VIEW_BACKGROUND_DARK;
            
        }
        else
        {
            
            currentView.backgroundColor = VIEW_BACKGROUND_NORMAL;
            
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
        
        NSDictionary *movieDic = (NSDictionary *)result;
        
        [LTArchiver archiverObject:movieDic ByKey:@"movieDic" WithPath:@"movieDic.plist"];
        
        NSArray *arr = [[result objectForKey:@"data"] objectForKey:@"posts"];
        
        for (NSDictionary *dict in arr) {
            
            LTMovieModel *model = [[LTMovieModel alloc] initWithDic:dict];
            
            [self.dataSourceArray addObject:model];
            
            [model release];
            
        }
        
        
        [self.mainTableView reloadData];
    } failure:^(NSError *error) {
        
        NSDictionary *movieDic = [LTArchiver unarchiverObjectByKey:@"movieDic" WithPath:@"movieDic.plist"];
        
        NSArray *arr = [[movieDic objectForKey:@"data"] objectForKey:@"posts"];
        
        for (NSDictionary *dict in arr) {
            
            LTMovieModel *model = [[LTMovieModel alloc] initWithDic:dict];
            
            [self.dataSourceArray addObject:model];
            
            [model release];
            
        }
        
        
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
#pragma mark 返回cell的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

#pragma mark cell的初始化
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTMoviePicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell"];
    
    LTMovieModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = model;
    
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

#pragma mark cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTMovieModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
    
    // 判断有图片
    if (model.mediaModelArray != nil && model.mediaModelArray.count > 0) {
        
        LTMovieMediasModel *mediaModel = [model.mediaModelArray firstObject];
        
        CGFloat scale = [mediaModel.h integerValue] / [mediaModel.w integerValue] * 1.0;
        
        return ScreenWidth * scale + 150;
        
    }
    
    return 150;
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
