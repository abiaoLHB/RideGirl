//
//  LHBTabBar.m
//  RideGirl
//
//  Created by LHB on 16/6/1.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBTabBar.h"
#import "LHBPublishViewController.h"

@interface LHBTabBar ()

@property (nonatomic,weak)UIButton *publishButton;

@end

@implementation LHBTabBar

//创建发布按钮
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //换掉tabbar以后在还tabbar的背景
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(publishBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        self.publishButton = btn;
    }
    return self;
}
- (void)publishBtnClick
{
    LHBPublishViewController *publishVC = [[LHBPublishViewController alloc] init];
    
    //这样弹出控制器的话，会导致弹出之前的控制器暂时挪出window，但是还会在内存中。当需要既要弹出新的控制器，而且还要半透明的看到之前的控制器，这样弹是实现不了的。
    //第一种方法实现发布页面
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:NO completion:nil];
    //第二种方法实现发布页面(这样做不太好，应为window的根控制器是tabbar控制器，而新加的控制器为普通控制器)
    //UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    //[rootVC.view addSubview:publishVC.view];
    //[rootVC addChildViewController:publishVC];
    //第三种方法，就是搞一个半透明的名，加到window或者控制器的view上。
    //第四种做法，自定义window。window.hidden = NO;自定义的window就回出来
    UIWindow *widow = [[UIWindow alloc] init];
    //颜色设置半透明
    widow.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
    //窗口的级别
    //UIWindowLevelNormal < UIWindowLevelStatusBar < UIWindowLevelAlert
    widow.windowLevel =  UIWindowLevelNormal;
    //这句话会让widow变为祝窗口并可见
    //[widow makeKeyAndVisible];
    //window比较牛逼，不需要加到谁的身上，直接hidden = NO就出来了。自定义窗口和系统默认的窗口事件是独立的
    //若果有提示框从顶部掉下来盖住了状态栏，就是这样实现的。搞一个比状态栏级别高的window
    //销毁窗口:widow = nil;窗口一死，上面的子控件也会死
    widow = nil;
    
}

//重写布局方法
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    //标记一下
    static BOOL added = NO;
    
    //设置发布按钮的frame
//    self.publishButton.width = self.publishButton.currentBackgroundImage.size.width;
//    self.publishButton.height = self.publishButton.currentBackgroundImage.size.height;
    self.publishButton.size = self.publishButton.currentBackgroundImage.size;
    self.publishButton.center = CGPointMake(width*0.5, height*0.5);
    
    
    //其他UITabBarButton的frame
    CGFloat buttonY = 0;
    //平分
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIControl *button in self.subviews) {
        //如果不是UITabBarButton类，跳出
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;{
//另一种判断方式            
//            if (![button isKindOfClass:[UIColor class]] || button == self.publishButton) continue;{
//            }
            
            CGFloat buttonX = buttonW *((index > 1)?(index + 1):index);
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            index ++;
            
            if (added == NO) {
                [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    added = YES;
}
- (void)buttonClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LHBTabBarDidSelectNotification  object:nil userInfo:nil];
}

@end
