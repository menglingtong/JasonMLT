//
//  LTCategoryViewController.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/23.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTMainListCategoryViewController.h"

#import "LTNetTool.h"

#import "LTMainListModel.h"

#import "LTMainListCategoryCell.h"

@interface LTMainListCategoryViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, retain) NSMutableArray *tempArray;

@end

@implementation LTMainListCategoryViewController

- (void)dealloc
{
    _mainCollectionView.delegate = nil;
    _mainCollectionView.dataSource = nil;
    [_mainCollectionView release];
    [_mainDataSourceArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = self.categoryName;
    
    
}

-(void)loadView
{
    [super loadView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    // 初始化数据源数组
    self.mainDataSourceArray = [[NSMutableArray alloc] init];
    
    // 请求数据
    [self askForDataWithUrlStr:self.url];
    
    // 初始化flowlayout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight - 64 - 44);
    
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    flowLayout.minimumLineSpacing = 0;
    
    flowLayout.minimumInteritemSpacing = 0;
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 初始化collection view
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 44) collectionViewLayout:flowLayout];
    
    self.mainCollectionView.backgroundColor = [UIColor whiteColor];
    
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    
    self.mainCollectionView.pagingEnabled = YES;
    
    self.mainCollectionView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:_mainCollectionView];
    [_mainCollectionView release];
    
    // 注册cell
    [self.mainCollectionView registerClass:[LTMainListCategoryCell class] forCellWithReuseIdentifier:@"mainListCell"];
    
    
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

#pragma mark 请求并解析数据
- (void) askForDataWithUrlStr:(NSString *)url
{
    
    [LTNetTool GetNetWithUrl:url body:nil header:nil response:LTJSON success:^(id result) {
        
        NSArray *arr = [[result objectForKey:@"data"] objectForKey:@"articles"];
        
        // 遍历字典,为model赋值
        for (NSInteger i = 1; i <= arr.count; i++) {
            
            if (i == 1) {
                
                // 创建临时数组
                self.tempArray = [NSMutableArray array];
                
            }
            
            
            LTMainListModel *model = [[LTMainListModel alloc] initWithDic:[arr objectAtIndex:(i - 1)]];
            
            [self.tempArray addObject:model];
            
            // model 每 3 个分一组
            if (i % 3 == 0) {
                
                [self.mainDataSourceArray addObject:self.tempArray];
                
//                [self.tempArray release];
                
                self.tempArray = [NSMutableArray array];
                
                continue;
            }
            
            
        }
        
        [self.mainCollectionView reloadData];
        
        
    } failure:^(NSError *error) {
        
        
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
#pragma mark <UICollectionViewDelegate, UICollectionViewDataSource>
#pragma mark 返回collection cell的数量
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.mainDataSourceArray.count;
}

#pragma mark 初始化cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    LTMainListCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mainListCell" forIndexPath:indexPath];
    
    NSMutableArray *arr = [self.mainDataSourceArray objectAtIndex:indexPath.item];
    
    cell.dataSource = arr;
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    
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
