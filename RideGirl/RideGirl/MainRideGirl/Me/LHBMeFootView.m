//
//  LHBMeFootView.m
//  RideGirl
//
//  Created by LHB on 16/7/6.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBMeFootView.h"
#import "LHBMeModel.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "LHBMeCustomButton.h"
#import "LHBMeWebViewViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface LHBMeFootView ()

@property (nonatomic,strong) AFHTTPSessionManager *manager;


@end

@implementation LHBMeFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self getData];
        
    }
    return self;
}
- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}


- (void)getData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";

    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];//SVProgressHUDStyleDark
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSArray *quauresArr = [LHBMeModel mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
    
        [self creatSquares:quauresArr];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:@"加载成功"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
            [SVProgressHUD dismissWithDelay:0.5];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
            [SVProgressHUD dismissWithDelay:0.5];

        });
    }];
    
}

- (void)creatSquares:(NSArray *)squaresArr
{
    // 一行最多4列
    int maxCols = 4;
    
    // 宽度和高度
    CGFloat buttonW = LHBScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i<squaresArr.count; i++) {
        // 创建按钮
        LHBMeCustomButton *button = [LHBMeCustomButton buttonWithType:UIButtonTypeCustom];
        // 监听点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 传递模型
        button.model = squaresArr[i];
        
        // 计算frame
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
        
        [self addSubview:button];
    }
    
    //万能公式
    //总页数 ＝＝ （总个数 ＋ 每页的最大数 － 1）／ 每页最大数
    NSUInteger rows = (squaresArr.count + maxCols - 1) / maxCols;
    
    // 计算footer的高度
    self.height = rows * buttonH;
    //    self.frame = CGRectMake(0, 0, 0, rows * buttonH);
    
    // 重绘。就是说网络请求可能慢，而这时候设置设置高度已经晚了，所以重会一下
    [self setNeedsDisplay];
    
    
    NSLog(@"真实footView的高度:self.height:%f,rows * buttonH:%f",self.height,rows * buttonH);
    //  真实footView的高度:self.height:843.750000,rows * buttonH:843.750000
}


- (void)buttonClick:(LHBMeCustomButton *)btn
{
    //取出当前的导航控制器
    UITabBarController *tabBarVC = (UITabBarController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVC.selectedViewController;
    
    LHBMeWebViewViewController *webViewVC = [[LHBMeWebViewViewController alloc] init];
    
    //要知道点击了哪个按钮对应的哪个模型，第一种做法，tag。第二种做法，给每个按钮绑定一个模型
    if (![btn.model.url hasPrefix:@"http"]) {
        webViewVC.url = @"http://www.budejie.com/tag/117/";
        webViewVC.navigationItem.title = @"RideGirl";
        
    }else{
        
        //有彩铃、购买流量什么的，牵扯到内购，被拒。这里统一条转到http://www.budejie.com/tag/117/
//        webViewVC.url = @"http://www.budejie.com/tag/117/";
        webViewVC.url = btn.model.url;
        webViewVC.navigationItem.title = btn.model.name;
    }
    [nav pushViewController:webViewVC animated:YES];
    
}

/**
 *  设置背景图片
 *  第一次显示的会调用
 */
- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
}


















@end
