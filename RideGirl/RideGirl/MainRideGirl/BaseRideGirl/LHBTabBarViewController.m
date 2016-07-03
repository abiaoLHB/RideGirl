//
//  LHBTabBarViewController.m
//  RideGirl
//
//  Created by LHB on 16/5/31.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBTabBarViewController.h"
#import "LHBEssenceViewController.h"
#import "LHBNewViewController.h"
#import "LHBFriendTrendsViewController.h"
#import "LHBMeViewController.h"
#import "LHBTabBar.h"
#import "LHBUINavigationController.h"

@interface LHBTabBarViewController ()

@end

@implementation LHBTabBarViewController

//该类第一次加载时调用一次
+ (void)initialize
{
    NSMutableDictionary *normalDic = [NSMutableDictionary dictionary];
    normalDic[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    normalDic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    NSMutableDictionary *selectDic = [NSMutableDictionary dictionary];
    //    selectDic[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    selectDic[NSFontAttributeName] = normalDic[NSFontAttributeName];
    selectDic[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalDic forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    
//    UIViewController *vc01 = [[UIViewController alloc] init];
//    vc01.view.backgroundColor = [UIColor yellowColor];
//    vc01.tabBarItem.title = @"精华";
//    vc01.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
//    vc01.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
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
    
//    NSMutableDictionary *normalDic = [NSMutableDictionary dictionary];
//    normalDic[NSFontAttributeName] = [UIFont systemFontOfSize:10];
//    normalDic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    
//    NSMutableDictionary *selectDic = [NSMutableDictionary dictionary];
////    selectDic[NSFontAttributeName] = [UIFont systemFontOfSize:10];
//    selectDic[NSFontAttributeName] = normalDic[NSFontAttributeName];
//    selectDic[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
//
//
//    UITabBarItem *item = [UITabBarItem appearance];
//    [item setTitleTextAttributes:normalDic forState:UIControlStateNormal];
//    [item setTitleTextAttributes:selectDic forState:UIControlStateSelected];
//
//    [self addChildViewController:vc01];
//    
//    
//    UIViewController *vc02 = [[UIViewController alloc] init];
//    vc02.view.backgroundColor = [UIColor orangeColor];
//    vc02.tabBarItem.title = @"跟帖";
//    vc02.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
//    vc02.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
//    [self addChildViewController:vc02];
//    
//    UIViewController *vc03 = [[UIViewController alloc] init];
//    vc03.view.backgroundColor = [UIColor redColor];
//    vc03.tabBarItem.title = @"关注";
//    vc03.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
//    vc03.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
//    [self addChildViewController:vc03];
//    
//    UIViewController *vc04 = [[UIViewController alloc] init];
//    vc04.view.backgroundColor = [UIColor lightGrayColor];
//    vc04.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
//    vc04.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
//    vc04.tabBarItem.title = @"我";
//    [self addChildViewController:vc04];


    //为了增大扩展性，建议把控制器在外面创建好
    [self setupChildVc:[[LHBEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selecteImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVc:[[LHBNewViewController alloc] init] title:@"跟帖" image:@"tabBar_new_icon" selecteImage:@"tabBar_new_click_icon"];
    
    [self setupChildVc:[[LHBFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selecteImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVc:[[LHBMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selecteImage:@"tabBar_me_click_icon"];
    
    
    //当系统tabbar不能满足需求时，比如这个tabbar中间是个加号按钮，通过一般的方法是不能搞定的，这是需要继承系统的tabar，做一些自定义，来替换系统的tabbar，而系统的tabbar是只读的，不能直接替换，可以通过kvc方式去替换。
    //更换tabar
//    self.tabBar = [[LHBTabBar alloc] init];//报错，只读
    //通过kvc赋值给下划线的属性.然后在这个自定义的tabbar里布局子控件
    [self setValue:[[LHBTabBar alloc] init] forKeyPath:@"tabBar"];
    
    //换掉tabbar以后在还tabbar的背景(写道自定义tabbar里)
//    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
}

/*
 * 封装子控制器
 */

- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selecteImage:(NSString *)selecteImage
{
    vc.navigationItem.title = title;
    //设置文字和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selecteImage];
    //这句代码会导致所有的控制器提前创建，因为你访问了控制器的view。只要你访问了控制器的view，控制器的view就会加载所以不能在这里设置控制器的view的颜色
//    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    LHBUINavigationController *nav = [[LHBUINavigationController alloc] initWithRootViewController:vc];
    //设置nav的背景图片 (去自定义导航栏设置)
//    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
//    或者(所有的UINavigationBar背景都一样)
//    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"] forBarMetrics:UIBarMetricsDefault ];
    [self addChildViewController:nav];
}





@end
