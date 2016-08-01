//
//  LHBLogInTool.m
//  RideGirl
//
//  Created by LHB on 16/7/29.
//  Copyright © 2016年 LHBCopyright. All rights reserved.
//

#import "LHBLogInTool.h"
#import "LHBLoginRegisterViewController.h"

@implementation LHBLogInTool

+ (void)saveUid:(NSString *)uid
{
    [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"uid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


/**
 *  登录工具类，用来判断程序是否登录。
 一般是登录成功后，把一些返回信息存到沙盒中，用来下次判断
 */

+ (NSString *)getUserID
{
  return  [self getUserID:NO];
}

+ (NSString *)getUserID:(BOOL)showLogInVC
{
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    if (showLogInVC) {
        //延时
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LHBLoginRegisterViewController *logInVC = [[LHBLoginRegisterViewController alloc] init];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:logInVC animated:YES completion:nil];
        });
    }
    return uid;
}

+ (BOOL)cheakLoginState
{
    if ([self getUserID])
    {
        return YES;
    }else{
        return NO;
    }
}


+ (void)removerUserID
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"uid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
