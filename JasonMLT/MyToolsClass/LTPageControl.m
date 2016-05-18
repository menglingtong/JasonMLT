//
//  LTPageControl.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/12.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTPageControl.h"

@implementation LTPageControl

-(void)dealloc
{
    [_pointColor release];
    [_selectedColor release];
    [_imageArray release];
    [super dealloc];
}


-(instancetype)initWithFrame:(CGRect)frame pageStyle:(LTPageControlStyle)pageStyle imageArray:(NSMutableArray *)imageArray
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // 设置默认未选中的颜色
        self.pointColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00];
        
        // 设置默认选中颜色
        self.selectedColor = [UIColor colorWithRed:0.99 green:0.76 blue:0.18 alpha:1.00];
        
        // 设置默认间距
        self.pageInteritemSpacing = 10;
        
        // 设置点的样式
        self.pageStyle = pageStyle;
        
        // 设置初始显示第几个
        self.currentPage = 0;
        
        self.imageArray = [NSMutableArray arrayWithArray:imageArray];
        
    }
    
    return self;
}


#pragma mark 重写pageCount的set方法
-(void)setPageCount:(NSInteger)pageCount
{
    if (_pageCount != pageCount) {
        
        _pageCount = pageCount;
        
        // 创建小点
        // 1. 获取当前对象的宽度
        CGFloat LTPageControllWidth = self.frame.size.width;
        
        // 小点的宽度
        CGFloat LTPointWidth = (LTPageControllWidth - (_pageCount - 1) * _pageInteritemSpacing) / _pageCount;
        
        // 2. 循环创建小点
        for (NSInteger i = 0; i < _pageCount; i++) {
            
            // 创建小点
            UIImageView *point = [[UIImageView alloc] init];
            
            switch (_pageStyle) {
                case LTPageControlStyleCircle:
                    
                    point.frame = CGRectMake((_pageInteritemSpacing + LTPointWidth) * i, 0, LTPointWidth, LTPointWidth);
                    
                    point.layer.cornerRadius = LTPointWidth / 2.0;
                    
                    point.layer.masksToBounds = YES;
                    
                    break;
                    
                case LTPageControlStyleSquare:
                    
                    point.frame = CGRectMake((_pageInteritemSpacing + LTPointWidth) * i, 0, LTPointWidth, 2);
                    
                    point.layer.masksToBounds = YES;
                    
                    break;
                    
                case LTPageControlStyleImage:
                    
                    
                    
                    break;
                    
                default:
                    break;
            }
            
            // 为每个小点添加tag值
            [point setTag:1000 + i];
            
            point.backgroundColor = _pointColor;
            
            [self addSubview:point];
            
        }
        
        UIImageView *selectedView = [self.subviews objectAtIndex:_currentPage];
        
        selectedView.backgroundColor = _selectedColor;
        
    }
}


#pragma mark 重写pointColor的set方法
-(void)setPointColor:(UIColor *)pointColor
{
    
    if (_pointColor != pointColor) {
        
        [_pointColor release];
        
        _pointColor = [pointColor retain];
        
        if (self.subviews.count != 0) {
            
            for (UIImageView *imageView in self.subviews) {
                
                imageView.backgroundColor = _pointColor;
                
            }
            
            // 为被选中的赋值
            UIImageView *imageView = [self.subviews objectAtIndex:_currentPage];
            
            imageView.backgroundColor = _selectedColor;
            
            
        }
        
        
    }
    
}

#pragma mark 重写selecteColor的set方法
-(void)setSelectedColor:(UIColor *)selectedColor
{
    
    if (_selectedColor != selectedColor) {
        
        [_selectedColor release];
        
        _selectedColor = [selectedColor retain];
        
        // 如果有1个以上的点,为当前的点赋值
        if (self.subviews.count) {
            
            UIImageView *imageView = [self.subviews objectAtIndex:_currentPage];
            
            imageView.backgroundColor = _selectedColor;
            
        }
        
    }
    
}


#pragma mark 重写currentPage的set方法
-(void)setCurrentPage:(NSInteger)currentPage
{
    
    if (_currentPage != currentPage) {
        
        _currentPage = currentPage;
        
        // 判断是否有图片
        if (self.subviews.count) {
            
            //改变没有被选中的颜色
            for (UIImageView *imageView in self.subviews) {
                
                imageView.backgroundColor = _pointColor;
                
            }
            
            UIImageView *imageView = [self.subviews objectAtIndex:_currentPage];
            
            imageView.backgroundColor = _selectedColor;
            
            [UIView animateWithDuration:.3 animations:^{
                
                imageView.transform = CGAffineTransformMakeScale(1.6, 1.6);
                
            } completion:^(BOOL finished) {
                
                imageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                
                //当翻页的时候pageControl会有个放大缩小的动动画
                
            }];
            
        }
        
    }
    
}
















/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
