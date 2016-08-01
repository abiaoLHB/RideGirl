//
//  LHBLogInTool.h
//  RideGirl
//
//  Created by LHB on 16/7/29.
//  Copyright © 2016年 LHBCopyright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHBLogInTool : NSObject
/**
 *  存储uid
 */
+ (void)saveUid:(NSString *)uid;


/**
 *  检测是否登录.YES已登录
 */
+ (BOOL)cheakLoginState;

/**
 *  获取用户id，也可以用来判断是否登录
 */
+ (NSString *)getUserID;

/**
 *  获取用户id,并根据bool值是否弹出登录控制器
 */
+ (NSString *)getUserID:(BOOL)showLogInVC;


/**
 *  注销功能，删除沙盒里的uid等等
 */
+ (void)removerUserID;


@end
