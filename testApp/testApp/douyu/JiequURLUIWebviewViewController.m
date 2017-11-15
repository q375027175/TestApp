//
//  JiequURLUIWebviewViewController.m
//  testApp
//
//  Created by juge on 2017/10/30.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "JiequURLUIWebviewViewController.h"

@interface JiequURLUIWebviewViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (strong, nonatomic) UIWebView *webview;

@end

@implementation JiequURLUIWebviewViewController

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
    //    self.textView.text = @"qq.com";
    //    [self getZiyuan];
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

- (UIWebView *)webview {
    if (!_webview) {
        _webview = [[UIWebView alloc] init];
        _webview.delegate = self;
    }
    return _webview;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.textView.text = [NSString stringWithFormat:@"%@\n\n开始加载",self.textView.text];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.textView.text = [NSString stringWithFormat:@"%@\n\n加载完成",self.textView.text];
    
    NSString *htmlStr = [self.webview stringByEvaluatingJavaScriptFromString:@"document.body.outerHTML"];
    
    self.textView.text = [NSString stringWithFormat:@"%@\n\n%@",self.textView.text,htmlStr];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    self.textView.text = [NSString stringWithFormat:@"%@\n\n%@",self.textView.text,request.URL.absoluteString];
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    self.textView.text = [NSString stringWithFormat:@"%@\n\n%@",self.textView.text,error.localizedDescription];

}

@end

