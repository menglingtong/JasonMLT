//
//  LTSearchBar.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/17.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTSearchBar.h"

#import "LTBaseView.h"


#pragma mark -
@implementation LTSearchBar

-(void)dealloc
{
    [_searchBar release];
    [_borderColor release];
    [_backgroundColor release];
    
    [super dealloc];
}
/**
 *  自定义初始化方法
 *
 *  @param frame           坐标
 *  @param cornerRadius    圆角
 *  @param borderWidth     边框宽度
 *  @param backgroundColor 背景颜色
 *  @param borderColor     边框颜色
 *
 *  @return self
 */
-(instancetype)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius borderWidth:(NSInteger)borderWidth backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // 初始化搜索框
        self.searchBar = [[UISearchBar alloc] initWithFrame:frame];
        
        self.searchBar.delegate = self;
        
        //设置背景图是为了去掉上下黑线
        self.searchBar.backgroundImage = [[UIImage alloc] init];
        // 设置SearchBar的颜色主题为白色
        self.searchBar.barTintColor = [UIColor whiteColor];
        
        self.cornerRadius = cornerRadius;
        self.borderWidth = borderWidth;
        self.borderColor = borderColor;
        self.backgroundColor = backgroundColor;
        
//        [self.searchBar LTSetCancelButtonTitle:@"取消"];
        
        
        [self addSubview:_searchBar];
        [_searchBar release];
        
        
    }
    
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.searchBar.placeholder = @"Search";
    
    // 通过KVC 的方式获取到 UISearchBar的私有属性并赋值
    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
    
    if (searchField) {
        
        // 设置搜索框背景颜色
        [searchField setBackgroundColor:self.backgroundColor];
        
        // 设置搜索框圆角
        searchField.layer.cornerRadius = self.cornerRadius;
        
        // 设置搜索框边框颜色
        searchField.layer.borderColor = self.borderColor.CGColor;
        
        // 设置边框宽度
        searchField.layer.borderWidth = self.borderWidth;
        
        searchField.layer.masksToBounds = YES;
    }
    
    
    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
    
}

#pragma mark -
#pragma mark <UISearchBarDelegate>
#pragma mark 搜索框开始编辑状态,获取第一响应者
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES animated:YES];
    
    [self.LTDelegate searchResultView];
    
}

#pragma mark 点击cancel按钮,退出编辑状态
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    searchBar.text = @"";
    
    [searchBar setShowsCancelButton:NO animated:YES];
    
    [searchBar endEditing:YES];
    
    [self.LTDelegate cancelSearchResultView];
    
}

#pragma mark 点击搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self.LTDelegate didBeginSearchWithCondition:searchBar.text];
    
    [searchBar endEditing:YES];
    
}

#pragma mark 搜索框文字改变
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchBar.text isEqualToString:@""]) {
        
        
    }
    else
    {
        [self.LTDelegate didBeginSearchWithCondition:searchBar.text];
    }
    
    
}




-(void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
    
}









@end
