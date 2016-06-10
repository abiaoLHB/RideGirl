//
//  LHBLoginRegisterViewController.m
//  RideGirl
//
//  Created by LHB on 16/6/9.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBLoginRegisterViewController.h"

@interface LHBLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginOrRegisterBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputBgViewLeftLeading;

@end

@implementation LHBLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)loginOrRegisterBtnClick:(UIButton *)sender {
    
    if (self.inputBgViewLeftLeading.constant == 0) {
        self.inputBgViewLeftLeading.constant = -self.view.width;
        sender.selected = YES;
    }else{
        self.inputBgViewLeftLeading.constant = 0;
        sender.selected = NO;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];

    }];
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}














@end
