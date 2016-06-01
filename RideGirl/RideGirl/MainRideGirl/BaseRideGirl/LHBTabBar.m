//
//  LHBTabBar.m
//  RideGirl
//
//  Created by LHB on 16/6/1.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBTabBar.h"

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
        [self addSubview:btn];
        
        self.publishButton = btn;
    }
    return self;
}

//重写布局方法
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
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
    for (UIView *button in self.subviews) {
        //如果不是UITabBarButton类，跳出
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;{
//另一种判断方式            
//            if (![button isKindOfClass:[UIColor class]] || button == self.publishButton) continue;{
//            }
            
            CGFloat buttonX = buttonW *((index > 1)?(index + 1):index);
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            index ++;
        }
    }
}


@end
