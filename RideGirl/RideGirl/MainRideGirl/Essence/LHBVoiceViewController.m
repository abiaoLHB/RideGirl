//
//  LHBVoiceViewController.m
//  RideGirl
//
//  Created by LHB on 16/6/11.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBVoiceViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>
#import "LHBWordModel.h"
#import "LHBWordTableViewCell.h"
#import "LHBCommentViewController.h"

@interface LHBVoiceViewController ()

@property (nonatomic,strong) AFHTTPSessionManager *manager;

@property (nonatomic,strong) NSMutableArray *dataArr;
//当前页码
@property (nonatomic,assign) NSInteger page;
//加载下一页时需要这个参数
@property (nonatomic,copy) NSArray *maxtime;
//上一次的请求参数，防止用户在网络慢的情况下，快速刷新＋加载数据，造成数据乱
@property (nonatomic,strong) NSDictionary *params;

@property (nonatomic,assign) NSInteger lastSelectedIndex;
@end

@implementation LHBVoiceViewController

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //舒适化tableView参数（以前是放在）
    [self setupTableView];
    //添加刷新控件
    [self setupRefresh];
}

static NSString *const LHBWordCellID = @"word";

#pragma mark - 初始化tableView参数
- (void)setupTableView
{
    //设置tableView的内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = LHBTitlesViewY+LHBTitlesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    //给cell注册个cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LHBWordTableViewCell class]) bundle:nil] forCellReuseIdentifier:LHBWordCellID];
    //监听tabBar点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelect) name:LHBTabBarDidSelectNotification object:nil];
}
#pragma mark - tabBar点击
- (void)tabBarSelect
{
    LHBLogFunc;
    //如果是连续选中2次，直接刷新
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex && self.tabBarController.selectedViewController == self.navigationController && [self.view isShowingOnKeyWindow])
    {
        [self.tableView.mj_header beginRefreshing];
    }
    //记录这一次选中的索引
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
}

#pragma mark -  初始化刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewWord)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreWord)];//MJRefreshBackNormalFooter
    //先隐藏(使用MJRefreshAutoNormalFooter时)（在tableView的数据源代理中印象就行了）
    //    self.tableView.mj_footer.hidden = YES;//MJRefreshAutoNormalFooter
}

#pragma mark - 加载新数据
- (void)loadNewWord
{
    [self.tableView.mj_footer endRefreshing];
    
    //每次加载新数据的时候，页码都变为第一页。这里是0
    self.page = 0;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] =@"31";
    //存一下请求参数
    self.params = params;
    
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) {//
            return ;
        }
        //存储maxtime，因为加载下一页时要用
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.dataArr = [LHBWordModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        //刷新完表格结束刷新
        [self.tableView.mj_header endRefreshing];
        
        // 只有在刷新成功了才清空页码，加载失败的话，页码是不动的，也就是说刷新之前有几页，就是几页
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) {//
            return ;
        }
        //刷新完表格结束刷新
        [self.tableView.mj_header endRefreshing];
        //如果网络请求失败的话，页码加上了，但请求没回来，这一页就丢失了，所以如果请求失败了，页码得减回来
        self.page--;
    }];
    
}
#pragma mark - 加载更多数据
- (void)loadMoreWord
{
    [self.tableView.mj_header endRefreshing];
    //加载下一页时，page＋＋
    self.page ++;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] =@"31";
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params){
            return ;
        }
        //再一次存储maxtime，因为加载下下一页时要用
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *newDataArr = [LHBWordModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.dataArr addObjectsFromArray:newDataArr];
        
        [self.tableView reloadData];
        //刷新完表格结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params){
            return ;
        }
        //刷新完表格结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    }];
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    tableView.mj_footer.hidden = (self.dataArr.count == 0);
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LHBWordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LHBWordCellID];
    
    LHBWordModel *model = self.dataArr[indexPath.row];
    //把模型传进去
    cell.wordModel = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LHBWordModel *model = self.dataArr[indexPath.row];
    
    return model.cellH;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LHBCommentViewController *commentVc = [[LHBCommentViewController alloc] init];
    commentVc.wordModel = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:commentVc animated:YES];
}
@end
