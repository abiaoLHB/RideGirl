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
    
    //注册cell
    [self.catgoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LHBRecommendCell class]) bundle:nil] forCellReuseIdentifier:leftRuseCellid];
    [self.rightUserTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LHBRecommendRightCell class]) bundle:nil] forCellReuseIdentifier:rightRuseCellid];
    
    
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.catgoryTableView) {
        return self.leftDataArr.count;
    }else{
        return self.rightDataArr.count;
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
        cell.rightModel = self.rightDataArr[indexPath.row];
        return cell;
    }
}

#pragma mark - tableView代理 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LHBRecommendModel *model = self.leftDataArr[indexPath.row];

    if (tableView == self.catgoryTableView) {
        NSMutableDictionary *pramDic = [NSMutableDictionary dictionary];
        pramDic[@"a"] = @"list";
        pramDic[@"c"] = @"subscribe";
        pramDic[@"category_id"] = @(model.id);
        
        // 点击哪个分类，就根据哪个分类的id去加载数据
        AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
        
        [manger GET:@"http://api.budejie.com/api/api_open.php" parameters:pramDic progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            
            self.rightDataArr = [LHBRecommendRightModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
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
        return 60;
    }
}







@end
