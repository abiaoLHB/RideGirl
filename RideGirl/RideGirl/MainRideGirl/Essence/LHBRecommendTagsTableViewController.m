//
//  LHBRecommendTagsTableViewController.m
//  RideGirl
//
//  Created by LHB on 16/6/7.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBRecommendTagsTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <MJExtension/MJExtension.h>
#import "LHBRecommendTagsTableViewCell.h"
#import "LHBRecommendTagsModel.h"

@interface LHBRecommendTagsTableViewController ()

@property (nonatomic,strong) AFHTTPSessionManager *manager;

@property (nonatomic,strong) NSArray *dataArr;

@end

static NSString *const TAGSCELLID = @"tags";

@implementation LHBRecommendTagsTableViewController



- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self loadTas];
   
}
- (void)setupTableView
{
    self.navigationItem.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LHBRecommendTagsTableViewCell class]) bundle:nil] forCellReuseIdentifier:TAGSCELLID];
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = LHBGlobalColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)loadTas
{
    NSMutableDictionary *pramDic = [NSMutableDictionary dictionary];
    pramDic[@"a"] = @"tag_recommend";//
    pramDic[@"action"] = @"sub";
    pramDic[@"c"] = @"topic";
    
    [SVProgressHUD showInfoWithStatus:@"正在加载数据"];
    //发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:pramDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.dataArr = [LHBRecommendTagsModel mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    LHBRecommendTagsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TAGSCELLID ];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}



@end
