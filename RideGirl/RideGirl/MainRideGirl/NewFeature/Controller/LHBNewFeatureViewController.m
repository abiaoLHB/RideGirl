//
//  LHBNewFeatureViewController.m
//  RideGirl
//
//  Created by LHB on 16/7/13.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBNewFeatureViewController.h"

@interface LHBNewFeatureViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong) NSArray *imageArr;

@end

@implementation LHBNewFeatureViewController


- (NSArray *)imageArr
{
    if (!_imageArr) {
        _imageArr = [NSArray array];
    }
    return _imageArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScrollView];
}

- (void)setupScrollView
{
    self.scrollView.backgroundColor = [UIColor orangeColor];
    self.scrollView.contentSize = CGSizeMake(LHBScreenW * 4, 0);
    self.scrollView.pagingEnabled = YES;
}




@end
