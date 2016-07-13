//
//  AppDelegate.m
//  RideGirl
//
//  Created by LHB on 16/5/31.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "AppDelegate.h"
#import "LHBPushGuideView.h"
#import "LHBTabBarViewController.h"
#import "LHBNewFeatureViewController.h"
#import "LHBTopWindow.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    LHBTabBarViewController *tabBarVC = [[LHBTabBarViewController alloc] init];
    
    
    NSString *key = @"CFBundleShortVersionString";
    //获得当前软件版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //获得沙盒中存储的上一次版本号
    NSString *sanBoxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if ([currentVersion isEqualToString:sanBoxVersion]) {//测试时删掉了！号
        LHBNewFeatureViewController *featureVC = [[LHBNewFeatureViewController alloc] init];
        self.window.rootViewController = featureVC;
        
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        //另一种做法，在tab里，给tabBarItem增加方法
        //    tabBarVC.delegate = self;
        self.window.rootViewController =tabBarVC;
    }
    [self.window makeKeyAndVisible];

    [LHBPushGuideView show];

    return YES;
}
#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //传viewController,可以通过下面这个方法得出是哪个控制器被点击
    //[tabBarController.childViewControllers indexOfObject:viewController];
    
    //传索引,也可以拿到哪个控制器被点击(也可以两个都传)
     //tabBarController.childViewControllers[索引]
    
//    控制器和索引都可以不用传，因为拿到tabbar，就知道了哪个控制器被点击
//    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
//    userInfo[LHBSeletecControllerKey] = viewController;
//    userInfo[LHBSeletecControllerIndexKey] = @(tabBarController.selectedIndex);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LHBTabBarDidSelectNotification  object:nil userInfo:nil];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
   
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
 
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
