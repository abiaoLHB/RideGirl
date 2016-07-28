//
//  LHBLoginRegisterViewController.m
//  RideGirl
//
//  Created by LHB on 16/6/9.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBLoginRegisterViewController.h"
#import "LHBCusTomTextField.h"
#import "LHBTopWindow.h"

@interface LHBLoginRegisterViewController ()
//注册帐号&已有帐号切换按钮
@property (weak, nonatomic) IBOutlet UIButton *loginOrRegisterBtn;
//登录手机文本输入框
@property (weak, nonatomic) IBOutlet UITextField *logInPhoneTextField;

@property (weak, nonatomic) IBOutlet LHBCusTomTextField *logInPassWordTextField;

@property (weak, nonatomic) IBOutlet LHBCusTomTextField *registerPhoneTextField;

@property (weak, nonatomic) IBOutlet LHBCusTomTextField *registerPassWordTextField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputBgViewLeftLeading;

/**
 *  登录按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
/**
 *  注册按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation LHBLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLoginOrRegirstTextField];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)]];
}
- (void)endEdit
{
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    //设置状态栏样式(也可以在登录按钮点击后，model视图动画执行完毕后在改变也行)
    [self stupStatsBar];
}

- (void)setupLoginOrRegirstTextField
{
    [self.logInPhoneTextField becomeFirstResponder];
    
    self.logInPhoneTextField.text = @"13716280757";
    self.logInPassWordTextField.text = @"123456";
}


- (IBAction)loginOrRegisterBtnClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (self.inputBgViewLeftLeading.constant == 0) {
         //;7  self.inputBgViewLeftLeading.constant = -self.view.width;
        sender.selected = YES;
    }else{
        self.inputBgViewLeftLeading.constant = 0;
        sender.selected = NO;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];

    }];
}

- (IBAction)back
{    [self.view endEditing:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //恢复状态栏
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [LHBTopWindow showWindow];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    //一、iOS7后，状态栏默认基于控制器控制，想改变哪个控制器状态栏的颜色，就在哪个控制器里写这个代码。单是当你搞一个window永远显示在每一个控制器上，用来滚到顶部时，这个方法就失效了，也就是说状态栏颜色就自动变黑了。解决方法：在infoplist文件里添加一个键值对View controller-based status bar appearance  ＝ NO，这样状态栏就不是基于控制器了，而是基于UIApplication,且全局都是统一样式。想象单独控制，就得进入控制器的时候设置一下，退出的时候恢复一下
    //二、也可以让回滚到顶部的window隐藏，在控制器返回时在显示.并且不要View controller-based status bar appearance 这个键值对。
    return UIStatusBarStyleLightContent;
    
}
- (void)stupStatsBar
{
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [LHBTopWindow hiddenWindow];
}

/**
 *  登录事件
 */

- (IBAction)logInAction:(id)sender
{
    [self.view endEditing:YES];
    
    if (self.logInPhoneTextField.text.length == 11 && self.logInPassWordTextField.text.length)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGINBTNCLICK" object:nil];
    }
}

/**
 *  注册事件
 */
- (IBAction)regirstAction:(id)sender
{
    NSLog(@"注册");

}










@end
