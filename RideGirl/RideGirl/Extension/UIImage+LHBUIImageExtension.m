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

+ (UIImage *)lhb_imageWithName:(NSString *)name
{
    //皮肤文件夹名字 red blue等,要从沙盒中取出
    NSString *dir = [[NSUserDefaults standardUserDefaults] stringForKey:SKINDIRNAME];
    //文件全路径
    NSString *path = [NSString stringWithFormat:@"Skins/%@/%@",dir,name];
    //根据文件全路径加载出来这个图片，并返回
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:nil]];
}

@end
