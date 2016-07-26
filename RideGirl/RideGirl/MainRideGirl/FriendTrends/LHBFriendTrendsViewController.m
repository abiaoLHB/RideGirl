//
//  LHBFriendTrendsViewController.m
//  RideGirl
//
//  Created by LHB on 16/5/31.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBFriendTrendsViewController.h"
#import "LHBRecommendViewController.h"
#import "LHBLoginRegisterViewController.h"

@interface LHBFriendTrendsViewController ()

@property (weak, nonatomic) IBOutlet UIView *testContentAppStoreBgView;

@end

@implementation LHBFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关注";
    
    //正常登陆界面
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageNormalName:@"friendsRecommentIcon" andHeightLightImageName:@"friendsRecommentIcon-click" target:self andAction:@selector(friendLeftBtnDown)];
//    
//    self.view.backgroundColor = LHBGlobalColor;

    //appstore上架
    [self appstore];
    
    
}

- (void)appstore
{
    self.testContentAppStoreBgView.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.testContentAppStoreBgView.bounds];
    webView.backgroundColor = LHBGlobalColor;
    webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.budejie.com/hot/"]]];
    [self.testContentAppStoreBgView addSubview:webView];
}


- (void)friendLeftBtnDown
{
    LHBRecommendViewController *recommendVC = [[LHBRecommendViewController alloc] init];
    [self.navigationController pushViewController:recommendVC animated:YES];
}

- (IBAction)loginRegister:(id)sender {
    NSLog(@"登录");
    LHBLoginRegisterViewController *logInVc = [[LHBLoginRegisterViewController alloc] init];
    [self.navigationController presentViewController:logInVc animated:YES completion:nil];
    
    
}


@end
