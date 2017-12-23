//
//  JiequUrlViewController.m
//  testApp
//
//  Created by juge on 2017/10/28.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "JiequUrlViewController.h"
#import <WebKit/WebKit.h>

@interface JiequUrlViewController() <WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (strong, nonatomic) WKWebView *webview;
@end

@implementation JiequUrlViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.bottom.equalTo(self.view.mas_centerY);
    }];
    
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button addTarget:self action:@selector(getZiyuan) forControlEvents:(UIControlEventTouchUpInside)];
    [button setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(@0);
        make.top.equalTo(self.textView.mas_bottom);
    }];
    
    [self.view addSubview:self.webview];
    
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(@0);
        make.top.equalTo(self.textView.mas_bottom);
    }];
    self.webview.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.webview stopLoading];
}

- (void)getZiyuan {
    [self.textView endEditing:YES];
    [self.webview stopLoading];
    if ([self.textView.text rangeOfString:@"http://"].length <= 0) {
        self.textView.text = [NSString stringWithFormat:@"http://%@", self.textView.text];
    }
    self.textView.editable = NO;
    NSURL *url = [NSURL URLWithString:self.textView.text];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    self.webview.hidden = NO;

    [self.webview loadRequest:request];
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.keyboardType = UIKeyboardTypeURL;
    }
    return _textView;
}

- (WKWebView *)webview {
    if (!_webview) {
        _webview = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webview.UIDelegate = self;
        _webview.navigationDelegate = self;
    }
    return _webview;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    CGLog(@"%@",message.name);
    CGLog(@"%@",message.body);
}


/// 1 页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.textView.text = [NSString stringWithFormat:@"%@\n\n开始加载",self.textView.text];
}

/// 2 开始获取到网页内容时返回
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    self.textView.text = [NSString stringWithFormat:@"%@\n\n开始获取网页内容",self.textView.text];
}

/// 3 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.textView.text = [NSString stringWithFormat:@"%@\n\n加载完成",self.textView.text];
//    [self.webview evaluateJavaScript:@"document.body.outerHTML" completionHandler:^(id _Nullable htmlStr, NSError * _Nullable error) {
//        self.textView.text = [NSString stringWithFormat:@"%@\n\n%@",self.textView.text,htmlStr];
//    }];
//    
//    [self.webview evaluateJavaScript:@"document.getElementsByTagName('p')" completionHandler:^(id _Nullable htmlStr, NSError * _Nullable error) {
//        CGLog(@"~~~~~~~~~~%@",htmlStr);
//    }];
//    
//    [self.webview evaluateJavaScript:@"all[1]" completionHandler:^(id _Nullable htmlStr, NSError * _Nullable error) {
//        CGLog(@"~~~~~~~~~~%@",htmlStr);
//    }];
}
/// 4 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    self.textView.text = [NSString stringWithFormat:@"%@\n\n加载失败",self.textView.text];
}

- (void)dealloc {
    
}

@end
