//
//  UIColor+LHBColorExtension.m
//  RideGirl
//
//  Created by LHB on 16/7/29.
//  Copyright © 2016年 LHBCopyright. All rights reserved.
//

#import "UIColor+LHBColorExtension.h"

@implementation UIColor (LHBColorExtension)
+ (UIColor *)colorWithKey:(NSString *)key
{
    //本项目的颜色plist
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HuanFu" ofType:@"plist"]];
    //normal和night都是要存沙盒的，当点击换肤按钮后，存储
    NSString *colorStr = dict[@"normal"][key];
    
    return nil;
}
@end
