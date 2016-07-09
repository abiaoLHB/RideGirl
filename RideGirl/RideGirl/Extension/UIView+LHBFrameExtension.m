//
//  UIView+LHBFrameExtension.m
//  RideGirl
//
//  Created by LHB on 16/6/1.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "UIView+LHBFrameExtension.h"

@implementation UIView (LHBFrameExtension)

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}



- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (BOOL)isShowingOnKeyWindow
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    //转换坐标系。将subView.frame  从 subView.superview的坐标系转换成window的坐标系，并返回一个新的frame
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];//nil默认就是window（屏幕坐标系）
    //引申出另一个写法
    // CGRect newFrame = [[UIApplication sharedApplication].keyWindow convertRect:-- toView:--];
    
    CGRect windowRect = keyWindow.bounds;
    
    //判断两个CGRect是否交叉
    BOOL isIntersects = CGRectIntersectsRect(newFrame, windowRect);
    
    return (!self.hidden) && (self.alpha > 0.01) && (self.window == keyWindow) && isIntersects;
}


+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
@end
