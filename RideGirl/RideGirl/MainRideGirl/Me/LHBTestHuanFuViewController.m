//
//  LHBTestHuanFuViewController.m
//  RideGirl
//
//  Created by LHB on 16/7/29.
//  Copyright © 2016年 LHBCopyright. All rights reserved.
//

#import "LHBTestHuanFuViewController.h"
#import "UIImage+LHBUIImageExtension.h"

@interface LHBTestHuanFuViewController ()

@end

@implementation LHBTestHuanFuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage lhb_imageWithName:@"test.png"];
    [self.view addSubview:imageView];
}



@end
