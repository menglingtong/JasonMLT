//
//  LTMainPicCategoryViewController.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/23.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTMainPicCategoryViewController.h"

#import "LTNetTool.h"

#import "LTMainPicModel.h"

#import "LTMainPicCategoryCell.h"

@interface LTMainPicCategoryViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation LTMainPicCategoryViewController

- (void)dealloc
{
    
    [_mainDataSourceArray release];
    [_mainTableView release];
    
    [_backBar release];
    [super dealloc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.categoryName;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

-(void)loadView
{
    [super loadView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.mainDataSourceArray = [[NSMutableArray alloc] init];
    
    [self askForDataWithUrlStr:self.url];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 -44) style:UITableViewStylePlain];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    self.mainTableView.showsVerticalScrollIndicator = NO;
    
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_mainTableView];
    [_mainTableView release];
    
    // 注册cell
    [self.mainTableView registerClass:[LTMainPicCategoryCell class] forCellReuseIdentifier:@"picCell"];
    
    
    
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
-(void)askForDataWithUrlStr:(NSString *)url
{
    [LTNetTool GetNetWithUrl:url body:nil header:nil response:LTJSON success:^(id result) {
        
        NSArray *arr = [[result objectForKey:@"data"] objectForKey:@"articles"];
        
        for (NSDictionary *dic in arr) {
            
            LTMainPicModel *model = [[LTMainPicModel alloc] initWithDic:dic];
            
            [self.mainDataSourceArray addObject:model];
            [model release];
            
        }
        
        [self.mainTableView reloadData];
    } failure:^(NSError *error) {
        
        
        
    }];
    
    
}


#pragma make -
#pragma make <UITableViewDelegate, UITableViewDataSource>
#pragma make 返回cell数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainDataSourceArray.count;
}

#pragma mark cell重用
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTMainPicCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"picCell"];
    
    LTMainPicModel *model = [self.mainDataSourceArray objectAtIndex:indexPath.row];
    
    cell.model = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LTMainPicModel *model = [self.mainDataSourceArray objectAtIndex:indexPath.row];
    
    CGFloat scale = 0;
    
    if (model.thumbnail_picsize) {
        
        NSArray *arr = [model.thumbnail_picsize componentsSeparatedByString:@","];
        
        scale = [arr[1] intValue] * 1.0 / [arr[0] intValue];
        
    }
    
    if ([self.categoryName isEqualToString:@"摄影札记"]) {
        
        return ScreenWidth * scale + 80;
        
    }
    
    if ([self.categoryName isEqualToString:@"妹子图"]) {
        
        return ScreenWidth * scale + 80;
        
    }
    
    if ([self.categoryName isEqualToString:@"美女"]) {
        
        return ScreenWidth * scale + 50;
        
    }
    
    if ([self.categoryName isEqualToString:@"图片"]) {
        
        return ScreenWidth * scale + 50;
        
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
