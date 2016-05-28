//
//  LTMainListCategoryCell.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/24.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTMainListCategoryCell.h"

#import "LTBaseView.h"

#import "LTListOnePicTableViewCell.h"

#import "LTListNoPicTableViewCell.h"

#import "LTMainListModel.h"

#import "LTWKWebView.h"

@implementation LTMainListCategoryCell

- (void)dealloc
{
    
    [_mainTableView release];
    
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.mainTableView = [[UITableView alloc] init];
        
        self.mainTableView.delegate = self;
        self.mainTableView.dataSource = self;
        
        self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.mainTableView.showsVerticalScrollIndicator = NO;
        
//        self.mainTableView.scrollEnabled = NO;
        
        // 注册cell
        [self.mainTableView registerClass:[LTListOnePicTableViewCell class] forCellReuseIdentifier:@"listOnePicCell"];
        [self.mainTableView registerClass:[LTListNoPicTableViewCell class] forCellReuseIdentifier:@"listNoPicCell"];
        
        [self.contentView addSubview:_mainTableView];
        [_mainTableView release];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.mainTableView makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView).offset(0);
        
        make.left.equalTo(self.contentView).offset(0);
        
        make.right.equalTo(self.contentView).offset(0);
        
        make.bottom.equalTo(self.contentView).offset(0);
        
    }];
    
    
}

-(void)setDataSource:(NSArray *)dataSource
{
    if (_dataSource != dataSource) {
        
        [_dataSource release];
        
        _dataSource = [dataSource retain];
        
    }
    
    [self.mainTableView reloadData];
}

#pragma mark -
#pragma mark <UITableViewDelegate, UITableViewDataSource>
#pragma mark 返回cell的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

#pragma mrak cell 初始化
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTMainListModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    if (!model.thumbnail_picsize) {
        
        LTListNoPicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listNoPicCell"];
        
        cell.model = model;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    if (model.thumbnail_picsize) {
        
        LTListOnePicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listOnePicCell"];
        
        cell.model = model;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTMainListModel *model = [self.dataSource objectAtIndex:indexPath.row];
    

    // 命令代理人执行代理方法
    [self.LTWebViewDelegate getToTheWKWebView:model.weburl];
    
}

#pragma mark cell 的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTMainListModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    if (!model.thumbnail_picsize) {
        
        return 113.5;
        
    }
    
    if (model.thumbnail_picsize) {
        
        return 217;
        
    }
    
    return 0;
}















@end
