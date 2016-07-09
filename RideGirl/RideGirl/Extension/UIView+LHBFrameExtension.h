//
//  UIView+LHBFrameExtension.h
//  RideGirl
//
//  Created by LHB on 16/6/1.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LHBFrameExtension)

@property (nonatomic,assign) CGSize size;

@property (nonatomic,assign) CGFloat width;

@property (nonatomic,assign) CGFloat height;

@property (nonatomic,assign) CGFloat x;

@property (nonatomic,assign) CGFloat y;

@property (nonatomic,assign) CGFloat centerX;

@property (nonatomic,assign) CGFloat centerY;

//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量
    所以得自己实现方法
 */

/**
 *  判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;


/**
 *  从xib中加载一个控件，xib和类名名字一致
 */
+ (instancetype)viewFromXib;

@end
