//
//  LHBAddTagsToolBar.m
//  RideGirl
//
//  Created by LHB on 16/7/9.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBAddTagsToolBar.h"
#import "LHBAddTagsViewController.h"

@interface LHBAddTagsToolBar ()

@property (weak, nonatomic) IBOutlet UIView *topView;


@end

@implementation LHBAddTagsToolBar

- (void)awakeFromNib
{
    //添加一个加号按钮，只创建一次就行了
    UIButton *addButton = [[UIButton alloc] init];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    //尺寸
    //1、
    //addButton.size = [UIImage imageNamed:@"tag_add_icon"].size;
    //2、
    //addButton.size = [addButton imageForState:UIControlStateNormal].size;
    //3、
    addButton.size = addButton.currentImage.size;
    addButton.x = LHBMARGIN;
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:addButton];
}

- (void)addButtonClick
{
    LHBAddTagsViewController *addTagsVC = [[LHBAddTagsViewController alloc] init];
    
    //这一次这样拿这个控制器不对，因为selectedViewController的后面还model出来一个控制器，这个加号按钮是在model出来的这个控制器上面，而不是selectedViewController控制器
    //UITabBarController *tabBarVC = (UITabBarController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    //UINavigationController *nav = (UINavigationController *)tabBarVC.selectedViewController;
    
    //正确做法✅:谁把它model出来的，先找到谁，很显然是根控制器
    UIViewController *rootVC = [[UIApplication sharedApplication] keyWindow].
    rootViewController;
    
    //一旦一个控制器model出来另一个控制器，就会通过presentedViewController属性引用着它.也可以通过属性回去。
    //rootVC.presentedViewController.presentingViewController 等于 rootVC
//    [a presentViewController:b animated:YES completion:nil];
//    a model 出来 b 控制器
//    a.presentedViewController  ----> b
//    b.presentingViewController ----> a
    
    UINavigationController *nav = (UINavigationController *)rootVC.presentedViewController;
    [nav pushViewController:addTagsVC animated:YES];
}























@end
