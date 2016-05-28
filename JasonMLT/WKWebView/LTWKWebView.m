//
//  LTWKWebView.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/27.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTWKWebView.h"


@interface LTWKWebView ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, copy) NSString *str;

@end

@implementation LTWKWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self; // 自定义返回按钮后，边缘返回手势失效，使边缘手势生效
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
//    self.navigationController.navigationBar.hidden = YES;
    
    [self createWebView];
    
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
    
    NSLog(@"%@", self.url);
}

//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    
//    self.navigationController.navigationBar.hidden = NO;
//}

-(void)createWebView
{
    
    NSString *js = @"document.getElementsByClassName('btm_tg')[0].style.display = 'NONE';document.getElementsByClassName('btm_tg')[1].style.display = 'NONE';document.getElementsByClassName('btm_tg')[2].style.display = 'NONE';document.getElementsByClassName('btm_tg')[3].style.display = 'NONE';document.getElementsByClassName('btm_tg')[4].style.display = 'NONE';document.getElementById('top').style.display = 'NONE';document.getElementsByClassName('tuiguang1)[0].style.display = 'NONE';document.getElementsByClassName('tuiguang2)[0].style.display = 'NONE';";
    
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    config.preferences.minimumFontSize = 14;
    
    config.preferences.javaScriptEnabled = YES;
    
    config.userContentController = [[WKUserContentController alloc] init];
    
    [config.userContentController addUserScript:userScript];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49) configuration:config];
    
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    [self.view addSubview:webView];
    
    
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [webView evaluateJavaScript:@"document.getElementsByClassName('btm_tg')[0].style.display = 'none'" completionHandler:nil];
    
    [webView evaluateJavaScript:@"document.getElementsByClassName('btm_tg')[1].style.display = 'none'" completionHandler:nil];
    
    [webView evaluateJavaScript:@"document.getElementsByClassName('btm_tg')[2].style.display = 'none'" completionHandler:nil];
    
    [webView evaluateJavaScript:@"document.getElementById('top').style.display = 'none'" completionHandler:nil];
    
    [webView evaluateJavaScript:@"document.getElementsByClassName('tuiguang1)[0].style.display = 'none'" completionHandler:nil];
}

#pragma mark goBack
- (void) didClickedGoBackBtn:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark refresh
- (void) didClickedRefreshBtn:(UIButton *)btn
{
//    [self askForDataWithUrlStr:self.url];
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
