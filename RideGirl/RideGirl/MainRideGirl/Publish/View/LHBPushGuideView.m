//
//  LHBPushGuideView.m
//  RideGirl
//
//  Created by LHB on 16/6/10.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBPushGuideView.h"

@implementation LHBPushGuideView

+ (instancetype)creatLHBPushGuideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (IBAction)guideBtnClose
{
    [self removeFromSuperview];
    
}

+ (void)show
{
    NSString *key = @"CFBundleShortVersionString";
    //获得当前软件版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //获得沙盒中存储的上一次版本号
    NSString *sanBoxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (![currentVersion isEqualToString:sanBoxVersion]) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        //指导页
        LHBPushGuideView *guideView = [LHBPushGuideView creatLHBPushGuideView];
        guideView.frame = window.frame;
        [window addSubview:guideView];
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
