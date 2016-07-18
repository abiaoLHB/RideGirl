//
//  UIImage+LHBUIImageExtension.m
//  RideGirl
//
//  Created by LHB on 16/7/3.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "UIImage+LHBUIImageExtension.h"

@implementation UIImage (LHBUIImageExtension)

- (UIImage *)circleImage
{
    // NO－>不透明,否则有黑色背景
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    //获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    //裁剪，超出圆的不显示了
    CGContextClip(ctx);
    //将图片内容画上去
    [self drawInRect:rect];
    //拿到处理完的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();;
    //结束上下文
    UIGraphicsEndImageContext();
    //返回处理完image
    return image;
}


@end
