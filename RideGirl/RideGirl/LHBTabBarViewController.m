//
//  LHBTabBarViewController.m
//  RideGirl
//
//  Created by LHB on 16/5/31.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBTabBarViewController.h"

@interface LHBTabBarViewController ()

@end

@implementation LHBTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController *vc01 = [[UIViewController alloc] init];
    vc01.view.backgroundColor = [UIColor yellowColor];
    vc01.tabBarItem.title = @"精华";
    vc01.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    vc01.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    [self addChildViewController:vc01];
    
    
    UIViewController *vc02 = [[UIViewController alloc] init];
    vc02.view.backgroundColor = [UIColor orangeColor];
    vc02.tabBarItem.title = @"跟帖";
    vc02.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    vc02.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    [self addChildViewController:vc02];
    
    UIViewController *vc03 = [[UIViewController alloc] init];
    vc03.view.backgroundColor = [UIColor redColor];
    vc03.tabBarItem.title = @"关注";
    vc03.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    vc03.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    [self addChildViewController:vc03];
    
    UIViewController *vc04 = [[UIViewController alloc] init];
    vc04.view.backgroundColor = [UIColor lightGrayColor];
    vc04.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    vc04.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    vc04.tabBarItem.title = @"我";
    [self addChildViewController:vc04];


}



@end
