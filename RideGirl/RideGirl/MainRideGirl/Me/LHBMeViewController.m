//
//  LHBMeViewController.m
//  RideGirl
//
//  Created by LHB on 16/5/31.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBMeViewController.h"

@interface LHBMeViewController ()

@end

@implementation LHBMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *settingRightBtnItem = [UIBarButtonItem itemWithImageNormalName:@"mine-setting-icon" andHeightLightImageName:@"mine-setting-icon-click" target:self andAction:@selector(settingRightBtnDown)];
    
    UIBarButtonItem *moonRightBtnItem = [UIBarButtonItem itemWithImageNormalName:@"mine-moon-icon" andHeightLightImageName:@"mine-moon-icon-click" target:self andAction:@selector(moonRightBtnDown)];
    
    self.navigationItem.rightBarButtonItems = @[settingRightBtnItem,moonRightBtnItem];
    
    
    self.view.backgroundColor = LHBGlobalColor;


}
- (void)settingRightBtnDown
{
    LHBLogFunc;
}
- (void)moonRightBtnDown
{
    LHBLogFunc;
}

@end
