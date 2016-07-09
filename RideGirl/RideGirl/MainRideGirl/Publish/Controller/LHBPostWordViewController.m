//
//  LHBPostWordViewController.m
//  RideGirl
//
//  Created by LHB on 16/7/8.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBPostWordViewController.h"
#import "LHBPlaceholderTextView.h"

@interface LHBPostWordViewController ()

@end

@implementation LHBPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
}


- (void)setupNav
{
    self.navigationItem.title = @"发表文字";
    
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
    
    //设置navBar的navigationItem分状态时候，要页面加载完毕才有效果。坏处是先看到默认色，再是设置的颜色
    //- (void)viewDidAppear:(BOOL)animated
    //{
    //    NSMutableDictionary *disabledDic = [NSMutableDictionary dictionary];
    //    disabledDic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    //    disabledDic[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    //    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:disabledDic forState:UIControlStateDisabled];
    //}
}

- (void)setupTextView
{
    LHBPlaceholderTextView *textView = [[LHBPlaceholderTextView alloc] init];
    //虽然是self.view.bounds,但是textView继承自scrollView，默认从64开始
    textView.frame = self.view.bounds;
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    
    [self.view addSubview:textView];
}




- (void)canle
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)publish
{
  
}
/*
 UITextField *textField默认的情况
 1.只能显示一行文字
 2.有占位文字
 
 UITextView *textView默认的情况
 2.能显示任意行文字
 2.没有占位文字
 
 文本输入控件,最终希望拥有的功能
 1.能显示任意行文字
 2.有占位文字
 
 最终的方案:
 1.继承自UITextView
 2.在UITextView能显示任意行文字的基础上,增加"有占位文字"的功能
 */


@end
