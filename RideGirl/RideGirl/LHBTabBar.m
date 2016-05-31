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
    
    //设置发布按钮的frame
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center =CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);;
    
    
    //其他UITabBarButton的frame
    CGFloat buttonY = 0;
    //平分
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        //如果不是UITabBarButton类，跳出
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;{
            CGFloat buttonX = buttonW *((index > 1)?(index + 1):index);
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            index ++;
        }
    }
}


@end
