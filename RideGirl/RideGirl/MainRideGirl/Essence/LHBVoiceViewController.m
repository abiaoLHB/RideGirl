//
//  LHBVoiceViewController.m
//  RideGirl
//
//  Created by LHB on 16/6/11.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBVoiceViewController.h"

@interface LHBVoiceViewController ()

@end

@implementation LHBVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}
#pragma mark - 初始化tableView参数
- (void)setupTableView
{
    //设置tableView的内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = LHBTitlesViewY+LHBTitlesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

#pragma mark - Table view data source
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@---%zd",NSStringFromClass([self class]),indexPath.row];
    
    return cell;
}
@end
