//
//  UIColor+LHBColorExtension.h
//  RideGirl
//
//  Created by LHB on 16/7/29.
//  Copyright © 2016年 LHBCopyright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LHBColorExtension)
/**
 *  换肤方案
 *
 *  @return 根据key取出对应的颜色
 */
+ (UIColor *)colorWithKey:(NSString *)key;

@end
