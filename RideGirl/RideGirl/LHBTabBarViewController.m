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
    // 改变系统tabbar 选中图片的的渲染模式   第一种做法
//    //一、系统默认会把选中图片渲染成蓝色,可以更改渲染模式，来不让系统渲染
//    UIImage *image = [UIImage imageNamed:@"tabBar_essence_click_icon"];
//    //一直保持原始的图片
//    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc01.tabBarItem.selectedImage = image;
    
    //第二种做法:在Assets.xcassets中对不要渲染的图片的属性做更改:render as 

    
    
//    改变系统tabbar 文字的属性 ,其实是改变vc tabbarItem 的属性
    //第一种做法 更改文字属性
//    NSMutableDictionary *normalDic = [NSMutableDictionary dictionary];
//    normalDic[NSFontAttributeName] = [UIFont systemFontOfSize:10];
//    normalDic[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
//    [vc01.tabBarItem setTitleTextAttributes:normalDic forState:UIControlStateNormal];
//    
//    NSMutableDictionary *selectDic = [NSMutableDictionary dictionary];
//    selectDic[NSFontAttributeName] = [UIFont systemFontOfSize:10];
//    selectDic[NSForegroundColorAttributeName] = [UIColor orangeColor];
//    [vc01.tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
    //第二种做法 ： 拿到tabBarItem的ppearance的外观、皮肤对象，并对它设置，这样所有tabBarItem的属性都一样了(使用条件：发现某个方法后面有 UI_APPEARANCE_SELECTOR 的宏)
    
    NSMutableDictionary *normalDic = [NSMutableDictionary dictionary];
    normalDic[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    normalDic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    NSMutableDictionary *selectDic = [NSMutableDictionary dictionary];
    selectDic[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    selectDic[NSForegroundColorAttributeName] = [UIColor darkGrayColor];


    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalDic forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
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
