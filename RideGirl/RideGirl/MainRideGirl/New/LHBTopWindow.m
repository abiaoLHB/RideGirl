//
//  LHBTopWindow.m
//  RideGirl
//
//  Created by LHB on 16/7/3.
//  Copyright © 2016年 LHB. All rights reserved.
//
#import "LHBTopWindow.h"
#import <UIKit/UIKit.h>

@implementation LHBTopWindow

//保住window的名。因为要在类方法中使用，所以不能使用成员变量
static UIWindow *window_;

/**
 *  只创建一次
 */
+ (void)initialize
{
    window_ = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, LHBScreenW, 20)];
    window_.windowLevel = UIWindowLevelAlert;
    //window_.frame = CGRectMake(0, 0, LHBScreenW, 20);
    window_.backgroundColor = [UIColor yellowColor];
    //给window设置一个根控制器，不然会崩，以前只会警告
//    window_.rootViewController =[[UIViewController alloc] init];
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+ (void)showWindow
{
//    window_.hidden = NO;
}
/**
 *  应该是类方法，因为self是类
 */
+ (void)windowClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
    
}
+ (void)searchScrollViewInView:(UIView *)superView
{
    for (UIScrollView *subView in superView.subviews) {
    
        CGRect windowRect = [[UIApplication sharedApplication] keyWindow].bounds;
        
        //转换坐标系。将subView.frame  从 subView.superview的坐标系转换成window的坐标系，并返回一个新的frame
        CGRect newFrame = [subView.superview convertRect:subView.frame toView:nil];//nil默认就是window（屏幕坐标系）
        //引申出另一个写法
       // CGRect newFrame = [[UIApplication sharedApplication].keyWindow convertRect:subView.frame fromView:subView.superview];
        
        //判断两个CGRect是否交叉
      BOOL isJiaoCha =  CGRectIntersectsRect(windowRect, newFrame);
        
        
        if ([subView isKindOfClass:[UIScrollView class]] && isJiaoCha) {
            
            CGPoint offset = subView.contentOffset;
            offset.y = -subView.contentInset.top;
            [subView setContentOffset:offset animated:YES];
        }
        
        //继续查找子控件
        [self searchScrollViewInView:subView];
    }
}














@end
