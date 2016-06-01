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
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside  ];
    return [[self alloc] initWithCustomView:button];
}
@end
