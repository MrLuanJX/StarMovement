//
//  OtherViewController.m
//  ainanming
//
//  Created by 盛世智源 on 2018/12/20.
//  Copyright © 2018年 陆义金. All rights reserved.
//

#import "OtherViewController.h"
#import <WebKit/WebKit.h>



@interface OtherViewController ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate,UIActionSheetDelegate,WKScriptMessageHandler>

@property (nonatomic , strong) WKWebView * otherWebView;

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
}

-(void)createUI{
    
    if (![self.webURL containsString:@"http"]) {
        self.webURL = [@"http://" stringByAppendingString:self.webURL];
    }
    
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];

//    [config.userContentController addScriptMessageHandler:self name:@"addAddresList"];  // 跳转新增地址

    /*禁止缩放*/
    NSString *js = @" $('meta[name=description]').remove(); $('head').append( '<meta name=\"viewport\" content=\"width=device-width, initial-scale=1,user-scalable=no\">' );";
    
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
    [userContentController addUserScript:script];
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = preferences;
    
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    wkWebView.backgroundColor = [UIColor redColor];
    wkWebView.allowsBackForwardNavigationGestures = YES;
    wkWebView.navigationDelegate = self;
    wkWebView.UIDelegate = self;
    wkWebView.scrollView.delegate = self;

    // self.webURL
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.webURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.0];
    NSLog(@"webURL = %@",self.webURL);
    
    [wkWebView loadRequest:request];
    
    [self.view addSubview:wkWebView];
    
    self.otherWebView = wkWebView;

    [wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(INMScreenW);
       if ((void)(SAFE_AREA_INSETS_BOTTOM),safeAreaInsets().bottom > 0.0) {
           make.height.mas_equalTo(INMScreenH - INMFit(34));
       }else{
           make.height.mas_equalTo(INMScreenH);
       }
    }];
    
}

#pragma mark -- WKScriptMessageHandler
//JS调用OC方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    /* 返回首页js */
    if ([message.name isEqualToString: @"goToHome"]) {
       
    }
}

#pragma mark -- 捏合手势禁止缩放
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return nil;
}

#pragma mark - wkWebView代理
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark -网络加载指示器
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
     NSLog(@"加载失败");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == self.otherWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        
        //没有设置title 获取网页的title
//        self.titleLabel.text = INMNULLString(self.title)? self.otherWebView.title:self.title;
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    //    NSString * webUrl = [navigationAction.request.URL absoluteString];
    
    // 获取完整url并进行UTF-8转码
    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
    
    if ([strRequest hasPrefix:@"app://"]) {
        // 拦截点击链接
        //        [self handleCustomAction:strRequest];
        // 不允许跳转
        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        // 允许跳转
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

//接收到警告面板
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();//此处的completionHandler()就是调用JS方法时，`evaluateJavaScript`方法中的completionHandler
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (@available(iOS 11.0, *)) {
         self.otherWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

#pragma mark - 关闭按钮点击事件
- (void)closeNative{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 返回按钮点击事件
- (void)backNative{
    //判断是否有上一层H5页面
//    if ([self.otherWebView canGoBack]) {
//        //如果有则返回
//        [self.otherWebView goBack];
//    } else {
        [self closeNative];
//    }
}

// 记得取消监听
- (void)dealloc {
    //    [self.webView.configuration.userContentController removeAllUserScripts]; // 移除所有
}

@end
