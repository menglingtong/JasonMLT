//
//  LTMainViewController.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/11.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTMainViewController.h"

#import <UIImageView+WebCache.h>

#import "LTMainMenuCollectionCell.h"

#import "LTCategoryViewController.h"

#import <FMDB.h>

#import "LTNetTool.h"

#import "LTScrollModel.h"

#import <MJRefresh.h>

#import <UIImageView+WebCache.h>

#import "LTMainPicCategoryViewController.h"

#import "LTMainListCategoryViewController.h"

#import "LTTopicViewController.h"

#import "LTMovieViewController.h"


@interface LTMainViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/** 掉下来的封面图链接 */
@property (nonatomic, copy) NSString *fontImageStr;

/** 掉下来的图片 */
@property (nonatomic, retain) UIImageView *frontImage;

@end

@implementation LTMainViewController

-(void)dealloc
{
    [_frontImage release];
    
    [_mainMenuDataSourceArray release];
    
    [_mainMenuWillDeleteDictionary release];
    
    [_mainMenuWillDeleteArray release];
    
    _mainMenuCollectionView.delegate = nil;
    _mainMenuCollectionView.dataSource = nil;
    
    [_mainMenuCollectionView release];
    
    [_editView release];
    
    [_tempMovingCell release];
    
    [_pointedCellIndexPath release];
    
    [_moveIndexPath release];
    
    [_scrollViewDataSource release];
    
    [_scrollImage release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取本地document路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *dbPath = [documentPath stringByAppendingString:@"/JasonMLT.sqlite"];
    
    NSLog(@"%@", documentPath);
    
    // 判断文件存在就不执行创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbPath]) {
        
        // 创建数据库路径
        FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
        
        // 判断打开数据库连接
        if ([db open]) {
            
            // 创建栏目表 - 栏目ID(主键) - 栏目名称 -
            NSString *createCategorySql = @"create table if not exists category(cateID integer primary key autoincrement, categoryTitle varchar(225) not null)";
            
            NSString *createCategoryDetailSql = @"create table if not exists categoryDetail(title varchar(225) primary key not null, parentTitle varchar(225) not null, api_url varchar(225) not null, is_Selected integer not null, indexPath integer not null, pic varchar(225) not null, color varchar(225) not null)";
            
            // 执行创建语句
            [db executeUpdate:createCategorySql];
            [db executeUpdate:createCategoryDetailSql];
            
            // 获取plist文件
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Category" ofType:@"plist"];
            NSArray *array = [NSMutableArray arrayWithContentsOfFile:plistPath];
            
            // 解析plist文件
            for (NSDictionary *dic in array) {
                
                LTCategoryModel *categoryModel = [[LTCategoryModel alloc] init];
                
                [categoryModel initWithDic:dic];
                
                // 创建插入主栏目sql语句
                NSString *insertCategorySql = [NSString stringWithFormat:@"insert into category(categoryTitle) values('%@')", categoryModel.categoryTitle];
                
                // 执行语句
                [db executeUpdate:insertCategorySql];
                
                
                NSArray *categoryArray = [dic objectForKey:@"category"];
                
                for (NSDictionary *dicInArray in categoryArray) {
                    
                    if ([[dicInArray objectForKey:@"type"] isEqualToString:@"single"]) {
                        
                        
                        // 创建插入子栏目 sql语句
                        NSString *insertDetailCategorySql = [NSString stringWithFormat:@"insert into categoryDetail(title, parentTitle, api_url, is_Selected, indexPath, pic, color) values('%@', '%@', '%@', %d, %d, '%@', '%@')", [dicInArray objectForKey:@"title"], categoryModel.categoryTitle, [dicInArray objectForKey:@"api_url"], 0, 1000, [dicInArray objectForKey:@"pic"], [dicInArray objectForKey:@"color"]];
                        
                        [db executeUpdate:insertDetailCategorySql];
                    }
                    else
                    {
                        // 创建插入子栏目 sql语句
                        NSString *insertDetailCategorySql = [NSString stringWithFormat:@"insert into categoryDetail(title, parentTitle, api_url, is_Selected, indexPath, pic, color) values('%@', '%@', '%@', %d, %d, '%@', '%@')", [dicInArray objectForKey:@"title"], categoryModel.categoryTitle, @"子栏目", 0, 1000, [dicInArray objectForKey:@"pic"], [dicInArray objectForKey:@"color"]];
                        
                        [db executeUpdate:insertDetailCategorySql];
                        
                        NSArray *supCategory = [dicInArray objectForKey:@"subCategory"];
                        
                        for (NSDictionary *dict in supCategory) {
                            
                            NSString *insertSubCategorySql = [NSString stringWithFormat:@"insert into categoryDetail(title, parentTitle, api_url, is_Selected, indexPath, pic, color) values('%@', '%@', '%@', %d, %d, '%@', '%@')", [dict objectForKey:@"title"], [dicInArray objectForKey:@"title"], [dict objectForKey:@"api_url"], 0, 1000, @"图片", @"颜色"];
                            
                            [db executeUpdate:insertSubCategorySql];
                        }
                        
                    }
                    
                    
                }
                
                
            }
            
            [db close];
            
        }
        
    }
    
    
}



-(void)loadView
{
    [super loadView];
    
    
    self.imageClassArray = @[@"美女",@"妹子图", @"摄影札记", @"图片"];
    self.tableClassArray = @[@"今日看点", @"冷兔", @"爆笑日常", @"蝉游记", @"feekr旅行", @"旅游频道", @"汽车频道", @"时尚频道", @"", @"奢侈品频道", @"股票频道", @"财经新闻", @"科学频道", @"IT之家", @"网易娱乐"];
    
    // 初始化滚动视图数据源数组
    self.scrollViewDataSource = [[NSMutableArray alloc] init];
    
    // 调用请求方法,请求滚动视图数据
    [self askForScrollImageData];
    
    // 设置导航左侧按钮
//    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"userWhite"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedUserSetLeftButton:)] autorelease];
    
    // 设置导航右侧按钮
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plusWhite"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedAddCategoryButton:)] autorelease];
    
    
    // 调用方法初始化主菜单集合视图
    [self createMainMenuCollectionView];
    
    self.mainMenuCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self askForFronImagePage];
        
        
    }];
    
    
    @ea_weakify(self);
    // 设置主题切换时的回调方法
    [self.mainMenuCollectionView ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
        
        @ea_strongify(self);
        
        if([currentThemeIdentifier isEqualToString:EAThemeBlack])
        {
            
            currentView.backgroundColor = CELL_BACKGROUND_DARK;

            
        }
        else
        {
            
            currentView.backgroundColor = CELL_BACKGROUND_NORMAL;

            
        }
        
    }];
    
    
}

#pragma mark 请求掉下来的图片
- (void) askForFronImagePage
{
    
    NSString *frontImageApiUrl = @"http://iphone.myzaker.com/zaker/cover.php?_appid=iphone&_bsize=750_1334&_dev=iPhone%2C9.3.1&_idfa=44C64D22-DBB4-49AD-BB93-DC50565EFC46&_lat=0.000000&_lng=0.000000&_mac=02%3A00%3A00%3A00%3A00%3A00&_net=wifi&_udid=EFF67A40-E743-4850-978E-0E96FC82A7B2&_uid=&_utoken=&_v=6.5.2&_version=6.54&api_version=3.4";
    
    
    [LTNetTool GetNetWithUrl:frontImageApiUrl body:nil header:nil response:LTJSON success:^(id result) {
        
        self.fontImageStr = [[result objectForKey:@"data"] objectForKey:@"pic"];
        
        NSURL *url = [NSURL URLWithString:self.fontImageStr];
        
        self.frontImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight)];
        
        // 打开交互
        self.frontImage.userInteractionEnabled = YES;
        
        // 创建一个轻扫手势
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeFontImageBack)];
        
        // 设置清扫手势向上
        swipe.direction = UISwipeGestureRecognizerDirectionUp;
        
        [self.frontImage addGestureRecognizer:swipe];
        [swipe release];
        
        [self.frontImage sd_setImageWithURL:url];
        
        [self.tabBarController.view addSubview:_frontImage];
        [_frontImage release];
        
        
        [UIView animateKeyframesWithDuration:0.6 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeCubicPaced animations:^{
    
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.25 animations:^{
    
                self.frontImage.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
            }];
    
    
        } completion:^(BOOL finished) {
            
            
            
        }];
        
        
        
        
        [self.mainMenuCollectionView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

#pragma mark 将掉下来的图片送回去
- (void) swipeFontImageBack
{
    
    [UIView animateKeyframesWithDuration:0.6 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeCubicPaced animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.25 animations:^{
            
            self.frontImage.frame = CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight);
            
        }];
        
        
    } completion:^(BOOL finished) {
        
        
        
    }];
    
}

#pragma mark 请求滚动视图数据
- (void) askForScrollImageData
{
    
    NSString *scrollUrl = @"http://iphone.myzaker.com/zaker/follow_promote.php?_appid=iphone&_bsize=750_1334&_dev=iPhone%2C9.3.1&_idfa=44C64D22-DBB4-49AD-BB93-DC50565EFC46&_lat=0.000000&_lng=0.000000&_mac=02%3A00%3A00%3A00%3A00%3A00&_net=wifi&_udid=EFF67A40-E743-4850-978E-0E96FC82A7B2&_uid=&_utoken=&_v=6.5.2&_version=6.54&m=1462848242";
    
    
    [LTNetTool GetNetWithUrl:scrollUrl body:nil header:nil response:LTJSON success:^(id result) {
        
        NSArray *arr = [[result objectForKey:@"data"] objectForKey:@"list"];
        
        for (NSDictionary *dic in arr) {
            
            LTScrollModel *model = [[LTScrollModel alloc] initWithDic:dic];
            
            [self.scrollViewDataSource addObject:model];
            [model release];
            
        }
        
        // 初始化自定义滚动视图
        self.scrollImage = [[LTScrollImage alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (211 / 375.0) * self.view.frame.size.width) dataSource:self.scrollViewDataSource time:6 isCirculatory:YES isHasText:YES];
        
        [self.mainMenuCollectionView reloadData];
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

#pragma mark 页面即将出现
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    // 初始化数据源数组
    self.mainMenuDataSourceArray = [[NSMutableArray alloc] init];
    
    // 获取本地document路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *dbPath = [documentPath stringByAppendingString:@"/JasonMLT.sqlite"];
    
    // 创建数据库路径
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    if ([db open]) {
        
        NSString *sql = @"select * from categoryDetail where is_Selected = 1 order by indexPath asc";
        
        [db executeStatements:sql withResultBlock:^int(NSDictionary *resultsDictionary) {
           
            
            LTCategoryModel *model = [[LTCategoryModel alloc] initWithDic:resultsDictionary];
            
            [self.mainMenuDataSourceArray addObject:model];
            [model release];
            
            return 0;
        }];
        
    }
    
    [db close];
    
    [self.mainMenuCollectionView reloadData];
}

#pragma mark 初始化主菜单的集合视图 < mainMenuCollectionView >
- (void) createMainMenuCollectionView
{
    
    // 初始化编辑模式为假
    self.isEditing = NO;
    
    // 初始化删除数组
    self.mainMenuWillDeleteDictionary = [[NSMutableDictionary alloc] init];
    self.mainMenuWillDeleteArray = [[NSMutableArray alloc] init];
    
    // 设置集合视图的元素布局
    UICollectionViewFlowLayout *mainMenuFlowLayout = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    
    mainMenuFlowLayout.itemSize = CGSizeMake((ScreenWidth - 2) / 3, (ScreenWidth - 2) / 3);
    
    mainMenuFlowLayout.minimumLineSpacing = 1;
    mainMenuFlowLayout.minimumInteritemSpacing = 1;
    
    mainMenuFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 初始化集合视图
    self.mainMenuCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) collectionViewLayout:mainMenuFlowLayout];
    
    self.mainMenuCollectionView.backgroundColor = [UIColor whiteColor];
    
    self.mainMenuCollectionView.showsVerticalScrollIndicator = NO;
    
    self.mainMenuCollectionView.delegate = self;
    self.mainMenuCollectionView.dataSource = self;
    
    [self.view addSubview:_mainMenuCollectionView];
    [_mainMenuCollectionView release];
    
    // 注册cell
    [self.mainMenuCollectionView registerClass:[LTMainMenuCollectionCell class] forCellWithReuseIdentifier:@"mainMenuCell"];
    
    [self.mainMenuCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ltScrollImage"];
    
    
    // 创建也一个长按手势监听
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressCollectionViewCell:)];
    
    // 设置长按最小时长
    longPress.minimumPressDuration = 0.6;
    
    // 将长按手势添加给主菜单
    [self.mainMenuCollectionView addGestureRecognizer:longPress];
    
    // 初始化编辑菜单
    self.editView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 96)];
    
    self.editView.backgroundColor = [UIColor colorWithRed:0.99 green:0.76 blue:0.18 alpha:1.00];
    
    
    // 确认删除按钮
    self.deleteConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteConfirm.frame = CGRectMake(0, 0, ScreenWidth / 2.0, self.editView.frame.size.height);
    
    UIImageView *deleteConfirmImage = [[UIImageView alloc] initWithFrame:CGRectMake(157 / 2, 37 / 2, 60 / 2, 60 / 2)];
    
    deleteConfirmImage.image = [UIImage imageNamed:@"deleteBoldWhite"];
    
    [self.deleteConfirm addSubview:deleteConfirmImage];
    [deleteConfirmImage release];
    
    UILabel *deleteLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 48.5, 100, 30)];
    deleteLabel.text = @"Delete";
    deleteLabel.textAlignment = 1;
    deleteLabel.textColor = [UIColor whiteColor];
    
    [self.deleteConfirm addSubview:deleteLabel];
    [deleteLabel release];
    
    [self.deleteConfirm addTarget:self action:@selector(didClickedDeleteConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    
    // 将确认删除按钮添加到editView中
    [self.editView addSubview:_deleteConfirm];
    
    
    // 退出编辑模式按钮
    self.exitEditing = [UIButton buttonWithType:UIButtonTypeCustom];
    self.exitEditing.frame = CGRectMake(ScreenWidth / 2.0, 0, ScreenWidth / 2.0, self.editView.frame.size.height);
    
    UIImageView *exitImage = [[UIImageView alloc] initWithFrame:CGRectMake(157 / 2, 37 / 2, 60 / 2, 60 / 2)];
    
    exitImage.image = [UIImage imageNamed:@"exitWhite"];
    
    [self.exitEditing addSubview:exitImage];
    [exitImage release];
    
    UILabel *exitLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 48.5, 100, 30)];
    exitLabel.text = @"Exit";
    exitLabel.textAlignment = 1;
    exitLabel.textColor = [UIColor whiteColor];
    
    [self.exitEditing addSubview:exitLabel];
    [exitLabel release];
    
    [self.exitEditing addTarget:self action:@selector(didClickedExitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.editView addSubview:_exitEditing];
    
}


#pragma mark 长按手势监听事件
- (void) longPressCollectionViewCell:(UILongPressGestureRecognizer *)gesture
{
    // 获取手指在屏幕的点击位置
    CGPoint pointTouch = [gesture locationInView:self.mainMenuCollectionView];
    
    // 判断当前长按手势是否开始
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        // 获取当前点击的cell坐标
        NSIndexPath *indexPath = [self.mainMenuCollectionView indexPathForItemAtPoint:pointTouch];
        
        // 判断坐标是否为空
        if (indexPath == nil) {
            
            NSLog(@"空");
        
        }else{
            // 调用开启编辑模式的方法
            [self startMenuCollectionViewEditing];
            
            // 记录当前点击的cell
            self.pointedCellIndexPath = [self.mainMenuCollectionView indexPathForItemAtPoint:[gesture locationOfTouch:0 inView:gesture.view]];
            
            // 获取到当前坐标的cell
            UICollectionViewCell *cell = [self.mainMenuCollectionView cellForItemAtIndexPath:self.pointedCellIndexPath];
            
            // 获取当前cell的快照
            UIView *tempMoveCell = [cell snapshotViewAfterScreenUpdates:NO];
            
            // 将快照的view 赋值给 属性
            self.tempMovingCell = tempMoveCell;
            
            // 将快照当前的坐标赋值给 属性
            self.tempMovingCell.frame = tempMoveCell.frame;
            
            self.tempMovingCell.center = cell.center;
            
            __block LTMainViewController *LTSelf = self;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                // 设置快照 的中心点钉在点击位置
                LTSelf.tempMovingCell.center = cell.center;

                [[LTSelf.tempMovingCell layer] setMasksToBounds:NO];
                
                [[LTSelf.tempMovingCell layer] setShadowOffset:CGSizeMake(1, 1)];
                [[LTSelf.tempMovingCell layer] setShadowOpacity:0.8];
                [[LTSelf.tempMovingCell layer] setShadowColor:[UIColor grayColor].CGColor];
                
                
                LTSelf.tempMovingCell.bounds = CGRectMake(0, 0 , cell.frame.size.width + 10, cell.frame.size.height + 10);
                
            } completion:^(BOOL finished) {
                
                // 遍历可见的cell
                for (LTMainMenuCollectionCell *tempCell in [self.mainMenuCollectionView visibleCells]) {
                    
                    if (tempCell.isSelected) {
                        
                        tempCell.isEditImage.image = [UIImage imageNamed:@"radio-activeGray"];
                        
                    }
                    else
                    {
                        tempCell.isEditImage.image = [UIImage imageNamed:@"radioGray"];
                    }
                    
                }
                
            }];
            
            
            // 将存储快照的属性添加到当前集合视图中
            [self.mainMenuCollectionView addSubview:_tempMovingCell];
            // 疑问,为何释放出错,不是添加到数组中会增加一次持有吗?
//            [_tempMovingCell release];
            
            // 隐藏被点击的cell
            cell.hidden = YES;
            
            // 记录上一次点击的位置
            self.lastPoint = [gesture locationOfTouch:0 inView:gesture.view];
            
        }
    }
    
    // 判断当前在移动
    if (gesture.state == UIGestureRecognizerStateChanged) {
        
        // 获取移动的坐标 - x
        CGFloat moveX = [gesture locationOfTouch:0 inView:gesture.view].x - self.lastPoint.x;
    
        // 获取移动的坐标 - y
        CGFloat moveY = [gesture locationOfTouch:0 inView:gesture.view].y - self.lastPoint.y;
        
        // 移动临时视图的位置
        self.tempMovingCell.center = CGPointApplyAffineTransform(self.tempMovingCell.center, CGAffineTransformMakeTranslation(moveX, moveY));
        
        // 记录上一次点击的位置
        self.lastPoint = [gesture locationOfTouch:0 inView:gesture.view];
        
        // 计算移动时的视图与哪个cell相交
        for (UICollectionViewCell *cell in [self.mainMenuCollectionView visibleCells]) {
            
            // 如果是本身cell 则略过
            if ([self.mainMenuCollectionView indexPathForCell:cell] == self.pointedCellIndexPath) {
                
                continue;
                
            }
            
            // 计算中心距
            CGFloat space = sqrtf(pow(_tempMovingCell.center.x - cell.center.x, 2) + powf(_tempMovingCell.center.y - cell.center.y, 2));
            
            
            // 如果相交一半就移动
            if (space <= _tempMovingCell.bounds.size.width / 2) {
                
                self.moveIndexPath = [self.mainMenuCollectionView indexPathForCell:cell];
                
                //更新数据源（移动前必须更新数据源）
                [self updateMainMenuDataSourceArray];
                
                //移动
                [self.mainMenuCollectionView moveItemAtIndexPath:self.pointedCellIndexPath toIndexPath:self.moveIndexPath];
                
                
                //通知代理
                //设置移动后的起始indexPath
                self.pointedCellIndexPath = self.moveIndexPath;
                
                
                break;
            }
            
            
        }
        
        
        
    }
    
    // 判断动画结束
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
        UICollectionViewCell *cell = [self.mainMenuCollectionView cellForItemAtIndexPath:self.pointedCellIndexPath];
        
        // 动画过程中关闭用户交互
        self.mainMenuCollectionView.userInteractionEnabled = NO;
        
        __block LTMainViewController *LTSelf = self;
        
        //给截图视图一个动画移动到隐藏cell的新位置
        [UIView animateWithDuration:0.25 animations:^{
            
            LTSelf.tempMovingCell.center = cell.center;
            
            LTSelf.tempMovingCell.bounds = cell.bounds;
            
        } completion:^(BOOL finished) {
            
            //移除截图视图、显示隐藏cell并开启交互
            [_tempMovingCell removeFromSuperview];
            
            cell.hidden = NO;
            
            LTSelf.mainMenuCollectionView.userInteractionEnabled = YES;
            
//            [LTSelf.mainMenuCollectionView reloadData];
            
        }];
        
        
    }
    
}

#pragma mark 更新数据源
- (void)updateMainMenuDataSourceArray{
    
    // 创建一个可变的临时数组
    NSMutableArray *temp = @[].mutableCopy;
    
    //获取数据源
    if (self.mainMenuDataSourceArray) {
        
        // 将对应collectionView的数据源数组赋值给 temp 临时数组
        [temp addObjectsFromArray:[self dataSourceArrayOfCollectionView:self.mainMenuCollectionView]];
        
    }
    
    
    for (int i = 0; i < temp.count; i++) {
        
//        [temp replaceObjectAtIndex:i withObject:[temp[i] mutableCopy]];
        
    }
    
    // 判断目标位置和点击位置是否是同一个分区
    if (_moveIndexPath.section == _pointedCellIndexPath.section) {
        
        NSMutableArray *orignalSection = temp;
        
        // 如果目标位置的indexPath.item 大于点击位置的indexPath.item
        if (_moveIndexPath.item > _pointedCellIndexPath.item) {
            
            // 从点击
            for (NSUInteger i = _pointedCellIndexPath.item; i < _moveIndexPath.item ; i++ ) {
                
                [orignalSection exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
                
            }
            
        }
        else
        {
            for (NSUInteger i = _pointedCellIndexPath.item; i > _moveIndexPath.item ; i-- ) {
                
                [orignalSection exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
            }
        }
    }
    
    //将重排好的数据传递给外部
    if ([self respondsToSelector:@selector(dragCellCollectionView:newDataArrayAfterMove:)]) {
        
        [self dragCellCollectionView:self.mainMenuCollectionView newDataArrayAfterMove:temp.copy];
        
    }
}

// 返回数据源数组
- (NSArray *)dataSourceArrayOfCollectionView:(UICollectionView *)collectionView{
    if (collectionView == _mainMenuCollectionView) {
        
        return _mainMenuDataSourceArray;
        
    }
    
    return nil;
}

- (void)dragCellCollectionView:(UICollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray{
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:newDataArray];
    
    self.mainMenuDataSourceArray = array;
}

#pragma mark 开启编辑模式
- (void) startMenuCollectionViewEditing
{
    
    self.isEditing = YES;
    
    [self.tabBarController.view addSubview:_editView];
  //  [_editView release];
    
    __block LTMainViewController *LTSelf = self;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        LTSelf.editView.frame = CGRectMake(0, ScreenHeight - 96, ScreenWidth, 96);
        
        
    } completion:^(BOOL finished) {
        
//        [self.mainMenuCollectionView reloadData];
        
    }];
    
}

#pragma mark deleteConfirm 确认删除按钮点击方法
- (void) didClickedDeleteConfirmButton:(UIButton *)sender
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"频道管理" message:[NSString stringWithFormat:@"你选择了%ld个频道,是否确定删除", self.mainMenuWillDeleteArray.count] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionLeft = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 此处隐藏效果有bug
//        for (NSIndexPath *indexPath in self.mainMenuWillDeleteArray) {
//            
//            LTMainMenuCollectionCell *cell = [self.mainMenuCollectionView cellForItemAtIndexPath:indexPath];
//            
//            cell.hidden = YES;
//            
//            
//        }
        
        // 新建一个临时数组用于存储 被筛选出来要删除的model
        NSMutableArray *tempArr = [NSMutableArray array];
        
        // 遍历所有的cell
        for (LTMainMenuCollectionCell *cell in [self.mainMenuCollectionView visibleCells]) {
            
            if (cell.isSelected) {
                
                // 获取到 状态是被选则的cell
                NSIndexPath *indexPath = [self.mainMenuCollectionView indexPathForCell:cell];
                
                // 将被选择的cell 移动到最后
                [self.mainMenuCollectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:self.mainMenuDataSourceArray.count - 1  inSection:0]];
                
                // 获取本地document路径
                NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                
                NSString *dbPath = [documentPath stringByAppendingString:@"/JasonMLT.sqlite"];
                
                // 创建数据库路径
                FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
                
                // 打开数据库
                [db open];
                
                // 遍历数据源中的model
                for (LTCategoryModel *model in self.mainMenuDataSourceArray) {
                    
                    // 如果数据源数组中的model 的title 与被选择的cell的menuNameLabel.text相等, 执行sql语句将其在数据库中的状态修改
                    if ([model.title isEqualToString:cell.menuNameLabel.text]) {
                        
                        NSString *sql = [NSString stringWithFormat:@"update categoryDetail set is_Selected = 0 where title = '%@'", cell.menuNameLabel.text];
                        

                        if ([db open]) {

                            [db executeUpdate:sql];
                            
                        }
                        
                        // 将被筛选出的model存储到临时数组中等待 从数据源数组中 删除
                        [tempArr addObject:model];
                        
                    }

                }

                // 关闭数据库
                [db close];

            }
            
        }
        
        // 将临时数组中的model从数据源数组中删除
        [self.mainMenuDataSourceArray removeObjectsInArray:tempArr];
        
        // 清空临时数组
        [tempArr removeAllObjects];
        
        // 将待删除的数组清空
        [self.mainMenuWillDeleteArray removeAllObjects];
        
        // 将待删除的字典清空
        [self.mainMenuWillDeleteDictionary removeAllObjects];
        
        // 刷新页面
        [self.mainMenuCollectionView reloadData];
        
        
    }];
    
    UIAlertAction *actionRight = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:actionLeft];
    
    [alertController addAction:actionRight];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark exit退出按钮点击方法
- (void) didClickedExitButton:(UIButton *)sender
{
    // 防止block中循环引用
    __block LTMainViewController *LTSelf = self;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        LTSelf.editView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 96);
        
    } completion:^(BOOL finished) {
        
        
        for (LTMainMenuCollectionCell *tempCell in [self.mainMenuCollectionView visibleCells])
        {
            
            tempCell.isEditImage.image = nil;
            tempCell.isSelected = NO;
            
            
        }
        
        // 退出编辑模式
        LTSelf.isEditing = NO;
        
        // 清空待删除数组 字典
        [LTSelf.mainMenuWillDeleteDictionary removeAllObjects];
        [LTSelf.mainMenuWillDeleteArray removeAllObjects];
        
        // 移除编辑按钮视图层
        [LTSelf.editView removeFromSuperview];
        
        // 刷新collectionView
        [LTSelf.mainMenuCollectionView reloadItemsAtIndexPaths:[LTSelf.mainMenuCollectionView indexPathsForVisibleItems]];
        
        // 获取本地document路径
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        NSString *dbPath = [documentPath stringByAppendingString:@"/JasonMLT.sqlite"];
        
        // 创建数据库路径
        FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
        
        [db open];
        
        for (LTMainMenuCollectionCell *tempCell in [self.mainMenuCollectionView visibleCells])
        {
            
            // 更新数据库
            NSString *updateSql = [NSString stringWithFormat:@"update categoryDetail set indexPath = %d where title = '%@'", (int)tempCell.indexPathOfItem, tempCell.menuNameLabel.text];
            
            
            if ([db open]) {
                
                [db executeUpdate:updateSql];
                
            }
            
        }
        
        [db close];
        
    }];
    
    [self.mainMenuCollectionView reloadData];
    
    
}

#pragma mark 用户设置按钮
- (void) didClickedUserSetLeftButton:(UIBarButtonItem *)sender
{
    NSLog(@"抽屉");
}

#pragma mark 添加栏目按钮
- (void) didClickedAddCategoryButton:(UIBarButtonItem *)sender
{
    // 如果在编辑状态,退出编辑状态
    if (_isEditing) {
        
        [self didClickedExitButton:nil];
        
    }
    
    LTCategoryViewController *ltCategory = [[LTCategoryViewController alloc] init];
    
    // 推出栏目页面
    [self.navigationController pushViewController:ltCategory animated:YES];
    [ltCategory release];
}

#pragma mark push新页面的时候,隐藏tabBar
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    self.hidesBottomBarWhenPushed = YES;
    
}

#pragma mark 返回主页面的时候,将隐藏的tabBar显示出来
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    self.hidesBottomBarWhenPushed = NO;
    
}

#pragma mark -
#pragma mark  <UICollectionViewDelegate, UICollectionViewDataSource>

#pragma mark 返回item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.mainMenuDataSourceArray.count;
    
}

#pragma mark collection Cell 初始化
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 判断是主菜单
    if (collectionView == _mainMenuCollectionView) {
        
        // 重用cell
        LTMainMenuCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mainMenuCell" forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor colorWithRed:0.99 green:0.86 blue:0.35 alpha:1.00];
        cell.backgroundColor = [UIColor whiteColor];
        
        LTCategoryModel *model = [self.mainMenuDataSourceArray objectAtIndex:indexPath.item];
        
        NSString *picName = [NSString stringWithFormat:@"%@", model.pic];
        
        UIImage *img = [[UIImage imageNamed:picName] imageWithRenderingMode:2];
        
        cell.LTImageView.image = img;
        
        @ea_weakify(self);
        // 设置主题切换时的回调方法
        [cell ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
            
            @ea_strongify(self);
            
            if([currentThemeIdentifier isEqualToString:EAThemeBlack])
            {
                
                cell.backgroundColor = CELL_BACKGROUND_DARK;
                cell.menuNameLabel.textColor = TEXT_COLOR_DARK;
                cell.LTImageView.tintColor = [UIColor grayColor];
                
            }
            else
            {
                
                cell.backgroundColor = CELL_BACKGROUND_NORMAL;
                cell.menuNameLabel.textColor = TEXT_COLOR_NORMAL;
                
                cell.LTImageView.backgroundColor = [UIColor whiteColor];
                
                NSString *str = [NSString stringWithFormat:@"0x%@", model.color];
                
                cell.LTImageView.tintColor = UIColorFromRGBA((NSInteger)str, 0.75);
                
                cell.LTImageView.clipsToBounds = YES;
                
            }
            
        }];
        
        
        cell.menuNameLabel.text = model.title;
        
        // 标识当前cell的排序
        cell.indexPathOfItem = indexPath.item;
        
        // 判断在编辑状态
        if (self.isEditing) {
            
            // 判断cell已经被选中(在删除字典中已存储)
            if ( [[self.mainMenuWillDeleteDictionary allKeys] containsObject:cell.menuNameLabel.text] ) {
                
                // 赋选中图片
                cell.isEditImage.image = [UIImage imageNamed:@"radio-activeGray"];
                cell.isSelected = YES;
                
            }
            // 判断cell未被选中
            else
            {
                
                cell.isEditImage.image = [UIImage imageNamed:@"radioGray"];
                cell.isSelected = NO;
                
            }
            
        }
        else
        {
            
            cell.isEditImage.image  = nil;
            
        }
        
        return cell;
        
    }
    
    return nil;
    
}

#pragma mark item 点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.mainMenuCollectionView) {
        
        LTMainMenuCollectionCell *cell = (LTMainMenuCollectionCell *)[self.mainMenuCollectionView cellForItemAtIndexPath:indexPath];
        
        // 当前为编辑模式,并且判断cell未被选择,点击选择
        if (_isEditing && cell.isSelected == NO) {
            
            cell.isEditImage.image = [UIImage imageNamed:@"radio-activeGray"];
            
            cell.isSelected = YES;
            
            // 将is_Seleted 与 categoryTitle 存入即将删除字典,方便更新数据库
            [self.mainMenuWillDeleteDictionary setObject:@"0" forKey:cell.menuNameLabel.text];
            
            // 将indexPath 存入 数组,方便更鞋页面
            [self.mainMenuWillDeleteArray addObject:indexPath];
            
            
        }
        // 当前为编辑模式,并且判断cell已被选择,点击取消选择
        else if (_isEditing && cell.isSelected)
        {
            
            cell.isEditImage.image = [UIImage imageNamed:@"radioGray"];
            
            cell.isSelected = NO;
            
            // 点击将从即将删除的 字典 与 数组 中移除
            [self.mainMenuWillDeleteDictionary removeObjectForKey:cell.menuNameLabel.text];
            
            [self.mainMenuWillDeleteArray removeObject:indexPath];
            
        }
        // 当前非编辑模式,点击跳转
        else if (_isEditing == NO)
        {
            LTCategoryModel *model = [self.mainMenuDataSourceArray objectAtIndex:indexPath.item];
            
            if ([self.imageClassArray containsObject:cell.menuNameLabel.text]) {
                
                LTMainPicCategoryViewController *picVC = [[LTMainPicCategoryViewController alloc] init];
                
//                LTCategoryModel *model = [self.mainMenuDataSourceArray objectAtIndex:indexPath.item];
                
                picVC.url = model.api_url;
                
                picVC.categoryName = model.title;
                
                [self.navigationController pushViewController:picVC animated:YES];
                
            }
            else if ([self.tableClassArray containsObject:cell.menuNameLabel.text])
            {
                
                LTMainListCategoryViewController *listVC = [[LTMainListCategoryViewController alloc] init];
                
//                LTCategoryModel *model = [self.mainMenuDataSourceArray objectAtIndex:indexPath.item];
                
                if ([model.api_url isEqualToString:@"子栏目"]) {
                    
                    // 获取本地document路径
                    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                    
                    NSString *dbPath = [documentPath stringByAppendingString:@"/JasonMLT.sqlite"];
                    
                    // 创建数据库路径
                    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
                    
                    if ([db open]) {
                        
                        NSString *str =[NSString stringWithFormat:@"select * from categoryDetail where parentTitle = '%@'", model.title];
                        
                        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                        
                        [db executeStatements:str withResultBlock:^int(NSDictionary *resultsDictionary) {
                            
                            LTCategoryModel *tempModel = [[LTCategoryModel alloc] initWithDic:resultsDictionary];
                            
                            [tempArray addObject:tempModel];
                            [tempModel release];
                            
                            return 0;
                        }];
                        
                        
                        LTCategoryModel *m = [tempArray objectAtIndex:0];
                        
                        listVC.url = m.api_url;
                        
                        [self.navigationController pushViewController:listVC animated:YES];
                    }
                    
                    
                    
                }
                else
                {
                    
                    listVC.url = model.api_url;
                    
                    listVC.categoryName = model.title;
                    
                    [self.navigationController pushViewController:listVC animated:YES];
                }
                
            }
            else if ([cell.menuNameLabel.text isEqualToString:@"专题频道"])
            {
                
                LTTopicViewController *topicVC = [[LTTopicViewController alloc] init];
                
                topicVC.categoryTitle = model.title;
                
                topicVC.url = model.api_url;
                
                [self.navigationController pushViewController:topicVC animated:YES];
                
            }
            else if ([cell.menuNameLabel.text isEqualToString:@"电影资讯"])
            {
                LTMovieViewController *movieVC = [[LTMovieViewController alloc] init];
                
                if ([model.api_url isEqualToString:@"子栏目"]) {
                    
                    // 获取本地document路径
                    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                    
                    NSString *dbPath = [documentPath stringByAppendingString:@"/JasonMLT.sqlite"];
                    
                    // 创建数据库路径
                    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
                    
                    if ([db open]) {
                        
                        NSString *str =[NSString stringWithFormat:@"select * from categoryDetail where parentTitle = '%@'", model.title];
                        
                        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                        
                        [db executeStatements:str withResultBlock:^int(NSDictionary *resultsDictionary) {
                            
                            LTCategoryModel *tempModel = [[LTCategoryModel alloc] initWithDic:resultsDictionary];
                            
                            [tempArray addObject:tempModel];
                            [tempModel release];
                            
                            return 0;
                        }];
                        
                        LTCategoryModel *m = [tempArray objectAtIndex:1];
                        
                        movieVC.url = m.api_url;
                        
                        movieVC.categoryTitle = m.title;
                        
                        
                        [self.navigationController pushViewController:movieVC animated:YES];
                        
                    }
                        
                }
                
            }

            
        }
        
     
    }
    
    
}

#pragma mark 设置section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView == _mainMenuCollectionView) {
        
        return 1;
        
    }
    return 1;
}

#pragma mark 设置section的Header为滚动视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ltScrollImage" forIndexPath:indexPath];
        
        [headerView addSubview:_scrollImage];
//        [_scrollImage release];
        
        return headerView;
    }
    
    return nil;
}

#pragma mark 设置 section header的高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, self.scrollImage.frame.size.height);
}


#pragma mark -
#pragma mark 设置main Collection 的移动
-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
