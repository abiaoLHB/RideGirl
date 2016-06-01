//
//  LHBRecommendViewController.m
//  RideGirl
//
//  Created by LHB on 16/6/1.
//  Copyright © 2016年 LHB. All rights reserved.
//  邀请关注

#import "LHBRecommendViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface LHBRecommendViewController ()

@end

@implementation LHBRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = LHBRGBColor(223, 223, 223);
    
    
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:@"正在加载"];
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSMutableDictionary *pramDic = [NSMutableDictionary dictionary];
    pramDic[@"a"] = @"category";
    pramDic[@"c"] = @"subscribe";
    
    [manger GET:@"http://api.budejie.com/api/api_open.php" parameters:pramDic progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LHBLog(@"%@",responseObject);
        [SVProgressHUD dismiss];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
}


@end
