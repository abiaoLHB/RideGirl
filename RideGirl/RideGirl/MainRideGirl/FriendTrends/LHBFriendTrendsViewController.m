//
//  LHBFriendTrendsViewController.m
//  RideGirl
//
//  Created by LHB on 16/5/31.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBFriendTrendsViewController.h"
#import "LHBRecommendViewController.h"

@interface LHBFriendTrendsViewController ()

@end

@implementation LHBFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageNormalName:@"friendsRecommentIcon" andHeightLightImageName:@"friendsRecommentIcon-click" target:self andAction:@selector(friendLeftBtnDown)];
    
    self.view.backgroundColor = LHBRGBColor(223, 223, 233);


}
- (void)friendLeftBtnDown
{
    LHBRecommendViewController *recommendVC = [[LHBRecommendViewController alloc] init];
    [self.navigationController pushViewController:recommendVC animated:YES];
}


@end
