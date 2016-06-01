//
//  UIBarButtonItem+LHBUIBarButtonItemExtension.h
//  RideGirl
//
//  Created by LHB on 16/6/1.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LHBUIBarButtonItemExtension)
/*
 *  快速创建一个UIBarButtonItem
 */
+ (instancetype)itemWithImageNormalName:(NSString *)imageNormalName andHeightLightImageName:(NSString *)heighLightImageName target:(id)target andAction:(SEL)action;

@end
