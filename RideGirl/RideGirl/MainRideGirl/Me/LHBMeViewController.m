//
//  LHBMeViewController.m
//  RideGirl
//
//  Created by LHB on 16/5/31.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBMeViewController.h"
#import "LHBMeCell.h"
#import "LHBMeFootView.h"

@interface LHBMeViewController ()

@end


@implementation LHBMeViewController

static NSString *LHBMeCellID = @"me";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupTableView];

    NSLog(@"%@",NSStringFromCGRect(self.tableView.tableFooterView.frame));
}

- (void)setupNav
{
    self.navigationItem.title = @"我的";
    UIBarButtonItem *settingRightBtnItem = [UIBarButtonItem itemWithImageNormalName:@"mine-setting-icon" andHeightLightImageName:@"mine-setting-icon-click" target:self andAction:@selector(settingRightBtnDown)];
    
    UIBarButtonItem *moonRightBtnItem = [UIBarButtonItem itemWithImageNormalName:@"mine-moon-icon" andHeightLightImageName:@"mine-moon-icon-click" target:self andAction:@selector(moonRightBtnDown)];
    
    self.navigationItem.rightBarButtonItems = @[settingRightBtnItem,moonRightBtnItem];
    

}

- (void)setupTableView
{
    self.tableView.backgroundColor = LHBGlobalColor;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //调整tableView
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    [self.tableView registerClass:[LHBMeCell class] forCellReuseIdentifier:LHBMeCellID];

    self.tableView.tableFooterView = [[LHBMeFootView alloc] init];
    
}

- (void)settingRightBtnDown
{
    LHBLogFunc;
}
- (void)moonRightBtnDown
{
    LHBLogFunc;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LHBMeCell *cell = [tableView dequeueReusableCellWithIdentifier:LHBMeCellID];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}

@end
