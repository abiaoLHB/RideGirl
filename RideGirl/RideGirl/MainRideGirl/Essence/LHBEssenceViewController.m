//
//  LHBEssenceViewController.m
//  RideGirl
//
//  Created by LHB on 16/5/31.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBEssenceViewController.h"
#import "LHBTestVC.h"
@interface LHBEssenceViewController ()

@end

@implementation LHBEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置精华控制器的导航条
    //initWithImage的好处就是和图片尺寸大小一致
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBtn setBackgroundImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
//    [leftBtn setBackgroundImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
//    leftBtn.size = leftBtn.currentBackgroundImage.size;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    //纯文字情况下可以设置文字并添加事件
//    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:<#(nullable NSString *)#> style:<#(UIBarButtonItemStyle)#> target:<#(nullable id)#> action:(nullable SEL)];
    

    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageNormalName:@"MainTagSubIcon" andHeightLightImageName:@"MainTagSubIconClick" target:self andAction:nil];
    
    
    self.view.backgroundColor = LHBRGBColor(223, 223, 233);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    LHBTestVC *vc = [[LHBTestVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
