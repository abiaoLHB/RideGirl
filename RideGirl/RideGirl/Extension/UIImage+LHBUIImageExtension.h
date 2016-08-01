//
//  UIImage+LHBUIImageExtension.h
//  RideGirl
//
//  Created by LHB on 16/7/3.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LHBUIImageExtension)

/**
 *  转成圆形图片
 */
- (UIImage *)circleImage;
/**
 *  根据皮肤文件夹加载图片
 */
+ (UIImage *)lhb_imageWithName:(NSString *)name;


@end
