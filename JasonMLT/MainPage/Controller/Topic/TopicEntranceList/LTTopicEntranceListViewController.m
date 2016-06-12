//
//  LTTopicEntranceListViewController.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/26.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTTopicEntranceListViewController.h"

#import "LTNetTool.h"

#import "LTTopicEntranceListModel.h"

#import "LTEntranceNoPicCell.h"

#import "LTEntranceOnePicCell.h"

#import <UIImageView+WebCache.h>

#import "LTWKWebView.h"


@interface LTTopicEntranceListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *headPic;

@property (nonatomic, retain) UIImageView *headPicView;


@end

@implementation LTTopicEntranceListViewController

- (void)dealloc
{
    
    _mainTableView.delegate = nil;
    _mainTableView.dataSource = nil;
    [_mainTableView release];
    [_dataSourceArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self; // 自定义返回按钮后，边缘返回手势失效，使边缘手势生效
    
    self.navigationItem.title = self.entranceTitle;
    
//    self.navigationController.hidesBarsOnSwipe = YES;
}

-(void)loadView
{
    [super loadView];
    
    self.dataSourceArray = [[NSMutableArray alloc] init];
    
    
    [self askForDataWithUrlStr:self.url];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStylePlain];
    
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    self.mainTableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_mainTableView];
    [_mainTableView release];
    
    // 注册cell
    [self.mainTableView registerClass:[LTEntranceNoPicCell class] forCellReuseIdentifier:@"noPicCell"];
    
    [self.mainTableView registerClass:[LTEntranceOnePicCell class] forCellReuseIdentifier:@"onePicCell"];
    
    
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


#pragma mark 请求并解析数据
- (void) askForDataWithUrlStr:(NSString *)url
{
    
    [LTNetTool GetNetWithUrl:url body:nil header:nil response:LTJSON success:^(id result) {
        
        NSDictionary *entranceDic = (NSDictionary *)result;
        
        [LTArchiver archiverObject:entranceDic ByKey:@"entranceDic" WithPath:@"entranceDic.plist"];
        
        NSArray *arr = [[result objectForKey:@"data"] objectForKey:@"articles"];
        
//        NSString *imageFrame = [[[[result objectForKey:@"data"] objectForKey:@"block_info"] objectForKey:@"diy"] objectForKey:@"bgimage_frame"];
//        
//        NSString *h = [[imageFrame componentsSeparatedByString:@","] lastObject];
//        
//        NSInteger height = [h integerValue];
//        
//        self.headPic = [[[[result objectForKey:@"data"] objectForKey:@"block_info"] objectForKey:@"diy"] objectForKey:@"bgimage_url"];
//        
//        self.headPicView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
//        
//        [self.headPicView sd_setImageWithURL:[NSURL URLWithString:imageFrame]];
//        
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"addGray"] forBarMetrics:UIBarMetricsDefault];
        
        
        
        for (NSDictionary *dict in arr) {
            
            LTTopicEntranceListModel *model = [[LTTopicEntranceListModel alloc] initWithDic:dict];
            
            [self.dataSourceArray addObject:model];
            
            [model release];
            
        }
        
        [self.mainTableView reloadData];
    } failure:^(NSError *error) {
        
        NSDictionary *entranceDic = [LTArchiver unarchiverObjectByKey:@"entranceDic" WithPath:@"entranceDic.plist"];
        
        NSArray *arr = [[entranceDic objectForKey:@"data"] objectForKey:@"articles"];
        
        for (NSDictionary *dict in arr) {
            
            LTTopicEntranceListModel *model = [[LTTopicEntranceListModel alloc] initWithDic:dict];
            
            [self.dataSourceArray addObject:model];
            
            [model release];
            
        }
        
        [self.mainTableView reloadData];
        
    }];
    
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
    LTTopicEntranceListModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
    
    if (model.media == nil) {
    
        LTEntranceNoPicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noPicCell"];
        
        cell.model = model;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        @ea_weakify(self);
        // 设置主题切换时的回调方法
        [cell ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
            
            @ea_strongify(self);
            
            if([currentThemeIdentifier isEqualToString:EAThemeBlack])
            {
                cell.backgroundColor = CELL_BACKGROUND_DARK;
                cell.title.textColor = TEXT_COLOR_DARK;
                cell.author.textColor = TEXT_COLOR_DARK;
                
            }
            else
            {
                cell.backgroundColor = CELL_BACKGROUND_NORMAL;
                cell.title.textColor = TEXT_COLOR_NORMAL;
                cell.author.textColor = TEXT_COLOR_NORMAL;
                
            }
            
        }];
        
        return cell;
        
    }
    else
    {
        LTEntranceOnePicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"onePicCell"];
        
        cell.model = model;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        @ea_weakify(self);
        // 设置主题切换时的回调方法
        [cell ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
            
            @ea_strongify(self);
            
            if([currentThemeIdentifier isEqualToString:EAThemeBlack])
            {
                cell.backgroundColor = CELL_BACKGROUND_DARK;
                cell.title.textColor = TEXT_COLOR_DARK;
                cell.author.textColor = TEXT_COLOR_DARK;
                
            }
            else
            {
                cell.backgroundColor = CELL_BACKGROUND_NORMAL;
                cell.title.textColor = TEXT_COLOR_NORMAL;
                cell.author.textColor = TEXT_COLOR_DARK;
                
            }
            
        }];
        
        return cell;
    }


    return nil;
}
#pragma mark 点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTTopicEntranceListModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
    
    LTWKWebView *ltwv = [[LTWKWebView alloc] init];
    
    ltwv.url = model.weburl;
    
    [self.navigationController pushViewController:ltwv animated:YES];
}

#pragma mark 返回cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTTopicEntranceListModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
    
    if (model.media == nil) {
        
        return 100;
        
    }
    else
    {
        return 100;
        
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
