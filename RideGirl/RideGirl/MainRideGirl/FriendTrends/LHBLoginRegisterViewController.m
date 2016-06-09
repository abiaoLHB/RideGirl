//
//  LHBLoginRegisterViewController.m
//  RideGirl
//
//  Created by LHB on 16/6/9.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBLoginRegisterViewController.h"

@interface LHBLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@end

@implementation LHBLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    改变UITextField的placeholder的颜色
//    通过富文本
    
    //文字属性(一般)
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor blueColor];
//    NSAttributedString *placeholderStr = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attrs];
//    self.phoneTextField.attributedPlaceholder = placeholderStr;
    
    
    //文字属性（高级）
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"手机号"];
    [placeholder setAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                                 NSFontAttributeName : [UIFont systemFontOfSize:20]
                                 } range:NSMakeRange(0, 1)];
    [placeholder setAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor]} range:NSMakeRange(1, 1)];
    [placeholder setAttributes:@{NSForegroundColorAttributeName : [UIColor yellowColor]} range:NSMakeRange(2, 1)];
    self.phoneTextField.attributedPlaceholder = placeholder;
}




- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}














@end
