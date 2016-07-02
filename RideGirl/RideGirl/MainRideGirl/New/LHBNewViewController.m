//
//  LHBNewViewController.m
//  RideGirl
//
//  Created by LHB on 16/5/31.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBNewViewController.h"

@interface LHBNewViewController ()

@end

@implementation LHBNewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置精华控制器的导航条
    //initWithImage的好处就是和图片尺寸大小一致
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
   self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageNormalName:@"MainTagSubIcon" andHeightLightImageName:@"MainTagSubIconClick" target:self andAction:nil];    //纯文字情况下可以设置文字并添加事件
    //    se.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:<#(nullable NSString *)#> style:<#(UIBarButtonItemStyle)#> target:<#(nullable id)#> action:<#(nullable SEL)#>];
    
    self.view.backgroundColor = LHBGlobalColor;


}

@end
