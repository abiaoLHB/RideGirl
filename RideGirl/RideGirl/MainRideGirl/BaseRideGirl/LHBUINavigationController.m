//
//  LHBUINavigationController.m
//  RideGirl
//
//  Created by LHB on 16/6/1.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBUINavigationController.h"

@implementation LHBUINavigationController
/**
 * 当第一次使用这个类的时候会调用一次
 */
+ (void)initialize
{
//    当导航栏在LHBUINavigationController（当前类）中，appearance设置才会生效
//    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    //默认的在页面最左边右滑退出功能就没有了。清空他的代理就可以了
    //如果滑动移除控制器的功能失效。清空代理就实现了（让导航控制器重新设置这个功能）
    self.interactivePopGestureRecognizer.delegate = nil;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //只要事通过LHBUINavigationController创建的控制器，都能在这里拦截。这里拦截的目的是同一设置返回按钮. target和action传空就行
//    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    
    if (self.childViewControllers.count>0) {//如果push进来的不是第一个控制器
        //就做一个符合要求的返回按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
        //按钮内部所有那样左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //那边距，设置多少就往哪切多少（往那边跑）
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        //修改导航栏左边的item。只要这个被修改了，默认的在页面最左边右滑退出功能就没有了
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //这句super的push要放在后面，让viewController可以覆盖上面设置的leftBarButtonItem.也就是别的控制器要改一下时，还是能改动的
    [super pushViewController:viewController animated:animated];
}



- (void)back
{
    [self popViewControllerAnimated:YES];
}




































@end
