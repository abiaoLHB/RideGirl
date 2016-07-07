//
//  LHBMeWebViewViewController.m
//  RideGirl
//
//  Created by LHB on 16/7/7.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBMeWebViewViewController.h"
#import <NJKWebViewProgress/NJKWebViewProgress.h>

@interface LHBMeWebViewViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftBtnItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBtnItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *refushBtnItem;

@property (nonatomic,strong) NJKWebViewProgress *progress;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation LHBMeWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progress = [[NJKWebViewProgress alloc] init];
    
    //用来监听webView加载进度
    self.webView.delegate = self.progress;
    //还能监听webview的代理
    self.progress.webViewProxyDelegate = self;
    __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress){
        weakSelf.progressView.progress = progress;
        
        weakSelf.progressView.hidden = (progress == 1.0);
    };
    
    //webView在xib的位置（前、后）会影响显示，因为webView内部的scrollView会有一个64的间距。调一下位置就可以了
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    
    //webView进度条都是假的，因为要想真实的进度，牵扯到苹果私有的api
}

- (IBAction)goback:(id)sender {
    [self.webView goBack];

}

- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}

- (IBAction)reloda:(id)sender {
    [self.webView reload];
}

#pragma mark - 代理
//加载完毕
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //也就是说，这两个按钮能不能被点击，取决于webView能不能返回和前进
    self.leftBtnItem.enabled = webView.canGoBack;
    self.rightBtnItem.enabled = webView.canGoForward;
}



















@end
