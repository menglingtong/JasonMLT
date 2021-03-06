//
//  LTScrollImage.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/12.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTScrollImage.h"
#import <UIImageView+WebCache.h>

#import "LTScrollModel.h"


@implementation LTScrollImage 

-(void)dealloc
{
    [_scrollImageView release];
    [_scrollImageDataSource release];
    [_pageControl release];
    
    [super dealloc];
}

/**
 *  滚动视图自定义初始化方法
 *
 *  @param frame         滚动视图的frame
 *  @param dataSource    滚动视图的数据源数组
 *  @param time          滚动视图的时间间隔
 *  @param isCirculatory 滚动视图是否循环滚动
 *
 *  @return self
 */
-(instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource time:(NSInteger)time isCirculatory:(BOOL)isCirculatory isHasText:(BOOL)isHasText
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.isAddPageControl = NO;
        
        self.scrollImageDataSource = [[NSArray alloc] init];
        
        self.scrollImageDataSource = dataSource;
        
        self.Stime = time;
        
        self.isCirculatory = isCirculatory;
        
        self.isHasText = isHasText;
        
        self.scrollImageView = [[UIScrollView alloc] initWithFrame:frame];
        
        [self setLTScrollImageViewWithFrame:frame];
        
        [self addSubview:_scrollImageView];
        [_scrollImageView release];
        
        
        
    }
    
    return self;
}

#pragma mark 设置滚动视图具体细节
/**
 *  self.scrollImageView 的具体设置
 *
 *  @param frame         滚动视图的frame
 *  @param isCirculatory 滚动视图是否循环滚动
 */
- (void)setLTScrollImageViewWithFrame:(CGRect)frame
{
    // 设置滚动视图基本属性
    self.scrollImageView.pagingEnabled = YES;
    self.scrollImageView.showsHorizontalScrollIndicator = NO;
    self.scrollImageView.showsVerticalScrollIndicator = NO;
    self.scrollImageView.directionalLockEnabled = YES;
    
    self.scrollImageView.delegate = self;
    
    // 设置共有几张图
    self.numOfImage = self.scrollImageDataSource.count;
    
    // 如果判断要循环播放
    if (self.isCirculatory) {
        
        // 增加两张循环图的位置,用于存放尾图和首图
        self.numOfImage += 2;
        
        // 将偏移量修改为第二张图
        self.scrollImageView.contentOffset = CGPointMake(frame.size.width, 0);
        
    }
    
    // 设置滚动视图的空间
    self.scrollImageView.contentSize = CGSizeMake(frame.size.width * self.numOfImage, 0);
    
    
    // 向滚动视图中循环放图片
    for (NSInteger i = 0 ; i < self.numOfImage; i++) {
        
        // 判断是否循环
        if (self.isCirculatory) {
            
            // 若循环则从偏移量一个屏幕的位置铺设图片
            i += 1;
            
            if (i == self.scrollImageDataSource.count + 1) {
                
                break;
                
            }
            
        }
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height)];
        
        // 判断是否循环
        if (self.isCirculatory) {
            
            // 将i值还原
            i -= 1;
            
        }
        
        LTScrollModel *model = [self.scrollImageDataSource objectAtIndex:i];
        // 获取数组中的图片网络地址,并转换成NSURL类型
        NSURL *url = [NSURL URLWithString:model.promotion_img];
        
        // 使用SDWebImage 将图片请求到本地并放置到imageview上
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholderScroll"]];
        
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholderScroll"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 30, frame.size.width, 30)];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.backgroundColor = [UIColor colorWithRed:0.12 green:0.13 blue:0.13 alpha:0.60];
            
            [titleLabel setFont:[UIFont systemFontOfSize:14]];
            
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:model.title];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            
            style.firstLineHeadIndent = 10;
            
            [str addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, str.length)];
            
            titleLabel.attributedText = str;
            
            [imageView addSubview:titleLabel];
            [titleLabel release];
            
            
            
            if (self.isAddPageControl == 0) {
                
                // 添加pageControl (小点)
                self.pageControl = [[LTPageControl alloc] initWithFrame:CGRectMake(ScreenWidth / 2.67, ScreenHeight / 3.19, ScreenWidth / 3.75, 10) pageStyle:LTPageControlStyleSquare imageArray:nil];
                
                
                self.pageControl.pageCount = self.scrollImageDataSource.count;
                
                self.pageControl.pointColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00];
                
                self.pageControl.selectedColor = [UIColor colorWithRed:0.99 green:0.76 blue:0.18 alpha:1.00];
                
                self.pageControl.layer.contentsCenter = self.scrollImageView.layer.contentsCenter;
                
                [self addSubview:_pageControl];
                [_pageControl release];
                
                [self.scrollImageView bringSubviewToFront:_pageControl];
                
                self.isAddPageControl = YES;
                
            }
            
            
        }];
        
        // 将imageview 放到滚动视图中
        [self.scrollImageView addSubview:imageView];
        [imageView release];
        
    }
    
    // 循环滚动情况下,添加首图和尾图利于无缝滚动
    if (self.isCirculatory) {
        
        // 在第一个位置添加尾图
        UIImageView *first = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        LTScrollModel *model = [self.scrollImageDataSource lastObject];
        
        NSURL *FirstUrl = [NSURL URLWithString:model.promotion_img];
        
        [first sd_setImageWithURL:FirstUrl placeholderImage:[UIImage imageNamed:@"placeholderScroll"]];
        
        [self.scrollImageView addSubview:first];
        
        [first release];
        
        
        // 在最后一个位置添加首图
        UIImageView *last = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width * (self.numOfImage - 1), 0, frame.size.width, frame.size.height)];
        
        LTScrollModel *model2 = [self.scrollImageDataSource firstObject];
        
        NSURL *LastUrl = [NSURL URLWithString:model2.promotion_img];
        
        [last sd_setImageWithURL:LastUrl placeholderImage:[UIImage imageNamed:@"placeholderScroll"]];
        
        [self.scrollImageView addSubview:last];
        
        [last release];
        
    }
    
    // 设置循环滚动
    // 初始化当前图片为角标是0的图片
    self.currentPage = 0;
    
    // 若循环滚动,则改为角标是1的图片
    if (self.isCirculatory) {
        
        self.currentPage = 1;
        
    }
    
    [NSTimer scheduledTimerWithTimeInterval:self.Stime target:self selector:@selector(setTimerCirculatory) userInfo:nil repeats:YES];
    
}

#pragma mark -
#pragma mark 播放滚动图片
- (void) setTimerCirculatory
{
    // 设置一个currentPage属性 记录当前第几张图片
    self.currentPage += 1;
    
    // 判断,当前的图片不是最后一张图
    if (self.currentPage != self.scrollImageDataSource.count + 1) {
        
        self.pageControl.currentPage = self.currentPage - 1;
        [self.scrollImageView setContentOffset:CGPointMake(self.frame.size.width * self.currentPage, 0) animated:YES];
        
    }
    
    
    if (self.currentPage == self.scrollImageDataSource.count + 1) {
        
        self.currentPage = 0;
        
        if (self.isCirculatory) {
            
            self.currentPage = 1;
            
        }
        self.pageControl.currentPage = self.currentPage - 1;
        [self.scrollImageView setContentOffset:CGPointMake(self.frame.size.width * self.currentPage, 0) animated:YES];
        
    }
    
}


#pragma mark <UIScrollViewDelegate>
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (self.isCirculatory) {
        
        if (self.scrollImageView.contentOffset.x == self.frame.size.width * (self.numOfImage - 1)) {
            
            self.scrollImageView.contentOffset = CGPointMake(self.frame.size.width, 0);
            
            self.currentPage = 0;
            
            if (self.isCirculatory) {
                
                self.currentPage = 1;
                
            }
            
            self.pageControl.currentPage = self.currentPage - 1;
            
        }
        
        if (self.scrollImageView.contentOffset.x == 0) {
            
            self.scrollImageView.contentOffset = CGPointMake(self.frame.size.width *(self.numOfImage - 2), 0);
            
            self.currentPage = self.scrollImageDataSource.count;
            
            self.pageControl.currentPage = self.currentPage - 1;
            
        }
        
    }
    
    self.pageControl.currentPage = self.scrollImageView.contentOffset.x / self.frame.size.width - 1;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
