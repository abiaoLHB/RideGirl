//
//  LHBRecommendViewController.m
//  RideGirl
//
//  Created by LHB on 16/6/1.
//  Copyright © 2016年 LHB. All rights reserved.
//  邀请关注

#import "LHBRecommendViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "LHBRecommendModel.h"
#import <MJExtension/MJExtension.h>
#import "LHBRecommendCell.h"
#import "LHBRecommendRightCell.h"
#import "LHBRecommendRightModel.h"
#import <MJRefresh/MJRefresh.h>


@interface LHBRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *leftDataArr;
@property (nonatomic,strong) NSArray *rightDataArr;
@property (weak, nonatomic) IBOutlet UITableView *catgoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightUserTableView;
@property (nonatomic,strong) NSMutableDictionary *pramDic;
@property (nonatomic,strong) AFHTTPSessionManager *manger;

@end

@implementation LHBRecommendViewController

static NSString * const leftRuseCellid = @"cellId";
static NSString *const  rightRuseCellid = @"user";

- (AFHTTPSessionManager *)manger
{
    if (_manger == nil) {
        _manger = [AFHTTPSessionManager manager];
    }
    return _manger;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LHBRGBColor(223, 223, 223);
    self.navigationItem.title = @"推荐关注";
    [self setupTableView];
    [self setupRefresh];
    [self loadLeftCatgory];
}

- (void)loadLeftCatgory
{
    [SVProgressHUD showWithStatus:@"正在加载"];
    
    self.manger.requestSerializer.timeoutInterval = 10.0;
    NSMutableDictionary *pramDic = [NSMutableDictionary dictionary];
    pramDic[@"a"] = @"category";
    pramDic[@"c"] = @"subscribe";
  
    //保存请求参数
    self.pramDic = pramDic;
    
    
    [self.manger GET:@"http://api.budejie.com/api/api_open.php" parameters:pramDic progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.pramDic != pramDic) {//block对外部的变量又一个引用的话，就会将上一个成员变量拿过来，这个pramdic就是请求前的pramDic
            return ;
        }
        
        [SVProgressHUD dismiss];
        //responseObject[@"lsit"]
        self.leftDataArr = [LHBRecommendModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.catgoryTableView reloadData];
        
        //刷新完表格，默认选中第一行.UITableViewScrollPositionTop是显示到最顶部
        [self.catgoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        //默认选中左侧第一行的数据后，刷新这一行的数据就行了
        [self.rightUserTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showWithStatus:@"加载失败"];
        [SVProgressHUD dismissWithDelay:1.0];
        
    }];
    

}

- (void)setupRefresh
{
    //头部
    self.rightUserTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
//    self.rightUserTableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
//        LHBLog(@"进入刷新");
//    }];
    //也可以
    self.rightUserTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    可以省略，因为试图出来，会先走数据源方法，在数据源方法根据数组长度已经处理隐藏了
//    self.rightUserTableView.mj_footer.hidden= YES;
}
#pragma mark - 加载最新数据
- (void)loadNewData
{
    //下拉刷新，两种方案
//    一、把要刷新的第一条数据的id给服务器，服务器返回比这条id更大的id的数据
//    二、根据页码刷新，刷新的都是第一页
    
//    上啦加载，两种方案
    //    一、把要加载的最后一条数据的id给服务器，服务器返回比这条id更小的id的数据
    //    二、根据页码加载，加载的都是比上一页大一页的数据
    
    LHBRecommendModel *model = self.leftDataArr[self.catgoryTableView.indexPathForSelectedRow.row];
    model.currentPage = 1;
    //再请求数据
    NSMutableDictionary *pramDic = [NSMutableDictionary dictionary];
    pramDic[@"a"] = @"list";
    pramDic[@"c"] = @"subscribe";
    pramDic[@"category_id"] = @(model.id);
    pramDic[@"page"] =@( model.currentPage);
    
    self.pramDic = pramDic;
    
    // 点击哪个分类，就根据哪个分类的id去加载数据
    
    [self.manger GET:@"http://api.budejie.com/api/api_open.php" parameters:pramDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSArray *userArr = [LHBRecommendRightModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //添加之前先清掉老数据
        [model.leftModelDataArr removeAllObjects];
        //添加到当前类别对应的用户数组中
        [model.leftModelDataArr addObjectsFromArray:userArr];
        //保存总页数
        model.total = [responseObject[@"total"] integerValue];
        
        //不是最后一次请求，没资格刷新
//        if (self.pramDic != pramDic) {
//            return ;
//        }
        //刷新右边表格
        [self.rightUserTableView reloadData];
        //结束刷新
        [self.rightUserTableView.mj_header endRefreshing];
        //假如本来就一页数据活着刷新一下总共就这些数据，那么底部控件也应该有相应的状态
        [self cheakFootState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.pramDic != pramDic) {
            return ;
        }
        
        [SVProgressHUD showWithStatus:@"刷新失败"];
        [self.rightUserTableView.mj_header endRefreshing];
    }];

}


#pragma mark - 加载更多数据
- (void)loadMoreData
{
    LHBRecommendModel *model = self.leftDataArr[self.catgoryTableView.indexPathForSelectedRow.row];
    
    NSMutableDictionary *pramDic = [NSMutableDictionary dictionary];
    pramDic[@"a"] = @"list";
    pramDic[@"c"] = @"subscribe";
    pramDic[@"category_id"] = @(model.id);
    pramDic[@"page"] = @(++model.currentPage);
    
    // 点击哪个分类，就根据哪个分类的id去加载数据
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    [manger GET:@"http://api.budejie.com/api/api_open.php" parameters:pramDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSArray *userArr = [LHBRecommendRightModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [model.leftModelDataArr addObjectsFromArray:userArr];
        //不是最后一次请求，没资格刷新
//        if (self.pramDic != pramDic) {
//            return ;
//        }
        [self.rightUserTableView reloadData];
        
        [self cheakFootState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.rightUserTableView.mj_footer endRefreshing];

    }];
    

}

- (void)setupTableView
{
    //注册cell
    [self.catgoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LHBRecommendCell class]) bundle:nil] forCellReuseIdentifier:leftRuseCellid];
    [self.rightUserTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LHBRecommendRightCell class]) bundle:nil] forCellReuseIdentifier:rightRuseCellid];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.catgoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.rightUserTableView.contentInset = self.catgoryTableView.contentInset;
}
//时刻监测foot状态
- (void)cheakFootState
{
    LHBRecommendModel *model = self.leftDataArr[self.catgoryTableView.indexPathForSelectedRow.row];
    //每次刷新右边数据时，都控制foot显示活着隐藏
    self.rightUserTableView.mj_footer.hidden = (model.leftModelDataArr.count == 0);
    
    if (model.leftModelDataArr.count == model.total) {
        [self.rightUserTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.rightUserTableView.mj_footer endRefreshing];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.catgoryTableView) {
        return self.leftDataArr.count;
    }else{
        LHBRecommendModel *model = self.leftDataArr[self.catgoryTableView.indexPathForSelectedRow.row];

        [self cheakFootState];
        
        return model.leftModelDataArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.catgoryTableView) {
        LHBRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:leftRuseCellid];
        cell.categroy = self.leftDataArr[indexPath.row];
        return cell;
    }else{
        LHBRecommendRightCell *cell = [tableView dequeueReusableCellWithIdentifier:rightRuseCellid];
        LHBRecommendModel *model =self.leftDataArr[self.catgoryTableView.indexPathForSelectedRow.row];
        cell.rightModel = model.leftModelDataArr[indexPath.row];

        return cell;
    }
}

#pragma mark - tableView代理 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.catgoryTableView) {
        //先结束刷新，防止网络比较慢时，连续点击几个按钮，会造成已存在的数据还要去刷新
        [self.rightUserTableView.mj_header endRefreshing];
        [self.rightUserTableView.mj_footer   endRefreshing];
        LHBRecommendModel *model = self.leftDataArr[indexPath.row];
        if (model.leftModelDataArr.count) {
            [self.rightUserTableView reloadData];
        }else{
            //选中那一行，就刷那一行右边的数据，没有数据就没有，放置看到由于网络缓慢导致点了这行还显示上一个标签所对应的右边残留的数据
            [self.rightUserTableView reloadData];
            //进入一个新页签，先开始刷新(其实就掉网络请求方法)
            [self.rightUserTableView.mj_header beginRefreshing];
        }

    }else{
        LHBLog(@"点击的右边:%zd",indexPath.row);
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.catgoryTableView) {
        return 44;
    }else{
        return 70;
    }
}

#pragma mark - 控制器的销毁
//如果一个控制器请求正在发送，突然把这个控制器销毁的处理方法
- (void)dealloc
{
    //用同一个manger的好处是都会把请求加入到operationqueue中。这样可以统一处理
    [self.manger.operationQueue cancelAllOperations];
}




@end
