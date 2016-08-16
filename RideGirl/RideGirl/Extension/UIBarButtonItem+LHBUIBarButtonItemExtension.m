//
//  UIBarButtonItem+LHBUIBarButtonItemExtension.m
//  RideGirl
//
//  Created by LHB on 16/6/1.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "UIBarButtonItem+LHBUIBarButtonItemExtension.h"

@implementation UIBarButtonItem (LHBUIBarButtonItemExtension)

+ (instancetype)itemWithImageNormalName:(NSString *)imageNormalName andHeightLightImageName:(NSString *)heighLightImageName target:(id)target andAction:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:imageNormalName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:heighLightImageName] forState:UIControlStateHighlighted];

//    第一种写法。本项目重写了size
//    button.size = button.currentBackgroundImage.size;

//    第二种写法。当别的项目中没有重写frame的方法时，要这样写
    CGSize size = button.currentBackgroundImage.size;
    button.frame = CGRectMake(0, 0, size.width, size.height);
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside  ];
    return [[self alloc] initWithCustomView:button];
}
@end
