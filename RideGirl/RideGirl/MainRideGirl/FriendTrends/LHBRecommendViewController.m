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

@end

@implementation LHBRecommendViewController

static NSString * const leftRuseCellid = @"cellId";
static NSString *const  rightRuseCellid = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupRefresh];
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = LHBRGBColor(223, 223, 223);
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer.timeoutInterval = 10.0;
    NSMutableDictionary *pramDic = [NSMutableDictionary dictionary];
    pramDic[@"a"] = @"category";
    pramDic[@"c"] = @"subscribe";
    
    [manger GET:@"http://api.budejie.com/api/api_open.php" parameters:pramDic progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        //responseObject[@"lsit"]
        self.leftDataArr = [LHBRecommendModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        [self.catgoryTableView reloadData];
        
        //刷新完表格，默认选中第一行.UITableViewScrollPositionTop是显示到最顶部
        [self.catgoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showWithStatus:@"加载失败"];
        [SVProgressHUD dismissWithDelay:1.0];

    }];
    
}
- (void)setupRefresh
{
//    self.rightUserTableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
//        LHBLog(@"进入刷新");
//    }];
    //也可以
    self.rightUserTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.rightUserTableView.mj_footer.hidden= YES;
}

#pragma mark - 加载更多数据
- (void)loadMoreData
{
    LHBRecommendModel *model = self.leftDataArr[self.catgoryTableView.indexPathForSelectedRow.row];
    
    NSMutableDictionary *pramDic = [NSMutableDictionary dictionary];
    pramDic[@"a"] = @"list";
    pramDic[@"c"] = @"subscribe";
    pramDic[@"category_id"] = @(model.id);
//    pramDic[@"page"] = @"2";
    // 点击哪个分类，就根据哪个分类的id去加载数据
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    [manger GET:@"http://api.budejie.com/api/api_open.php" parameters:pramDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *userArr = [LHBRecommendRightModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [model.leftModelDataArr addObjectsFromArray:userArr];
        
        [self.rightUserTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.catgoryTableView) {
        return self.leftDataArr.count;
    }else{
        LHBRecommendModel *model = self.leftDataArr[self.catgoryTableView.indexPathForSelectedRow.row];
        
        self.rightUserTableView.mj_footer.hidden = (model.leftModelDataArr.count == 0);
        
        
        
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
    LHBRecommendModel *model = self.leftDataArr[indexPath.row];
    if (model.leftModelDataArr.count) {
        [self.rightUserTableView reloadData];
    }else{
        //选中那一行，就刷那一行右边的数据，没有数据就没有，放置看到由于网络缓慢导致点了这行还显示上一个标签所对应的右边残留的数据
        [self.rightUserTableView reloadData];
        
       //再请求数据
            NSMutableDictionary *pramDic = [NSMutableDictionary dictionary];
            pramDic[@"a"] = @"list";
            pramDic[@"c"] = @"subscribe";
            pramDic[@"category_id"] = @(model.id);
            
            // 点击哪个分类，就根据哪个分类的id去加载数据
            AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
            
            [manger GET:@"http://api.budejie.com/api/api_open.php" parameters:pramDic progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSArray *userArr = [LHBRecommendRightModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                
                [model.leftModelDataArr addObjectsFromArray:userArr];
                
                [self.rightUserTableView reloadData];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
            

        
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







@end
