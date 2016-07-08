//
//  LHBPostWordViewController.m
//  RideGirl
//
//  Created by LHB on 16/7/8.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBPostWordViewController.h"

@interface LHBPostWordViewController ()

@end

@implementation LHBPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发表文字";
    self.view.backgroundColor = [UIColor redColor];
    
    //    改变导航栏title的样式 第一种方案
    //    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    //    titleLable.text = @"第一种方案";
    //    titleLable.font = [UIFont systemFontOfSize:17];
    //    titleLable.textColor = [UIColor orangeColor];
    //    self.navigationItem.titleView = titleLable;
    
    //第二种方案 title
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
   
   
    //左 navigationItem
    //iOS7以后style写什么都一样：UIBarButtonItemStyleDone
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(canle)];
    //更改navigationItem的文字颜色  第一种方案
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    NSMutableDictionary *attriDic = [NSMutableDictionary dictionary];
    attriDic[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    attriDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:attriDic forState:UIControlStateNormal];
   
    
    //右 navigationItem  也可以通过 APPEARANCE 全局设置
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(publish)];
    
    //默认不能点击
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    //normal
    NSMutableDictionary *rightAttriDic = [NSMutableDictionary dictionary];
    rightAttriDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    rightAttriDic[NSFontAttributeName] = attriDic[NSFontAttributeName];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:rightAttriDic forState:UIControlStateNormal];
  //设置navBar的navigationItem分状态时候,可以在viewDidAppear里设置状态，也可以强制刷新
    NSMutableDictionary *disabledDic = [NSMutableDictionary dictionary];
    disabledDic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disabledDic[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:disabledDic forState:UIControlStateDisabled];
    //强制刷新，监测状态
    [self.navigationController.navigationBar layoutIfNeeded];
}
//设置navBar的navigationItem分状态时候，要页面加载完毕才有效果。坏处是先看到默认色，再是设置的颜色
//- (void)viewDidAppear:(BOOL)animated
//{
//    NSMutableDictionary *disabledDic = [NSMutableDictionary dictionary];
//    disabledDic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    disabledDic[NSFontAttributeName] = [UIFont systemFontOfSize:17];
//    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:disabledDic forState:UIControlStateDisabled];
//}


- (void)canle
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)publish
{
    
}


@end
