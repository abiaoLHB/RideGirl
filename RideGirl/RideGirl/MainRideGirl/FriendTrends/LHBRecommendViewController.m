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

@interface LHBRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *leftDataArr;

@property (weak, nonatomic) IBOutlet UITableView *catgoryTableView;

@end

@implementation LHBRecommendViewController

static NSString * const leftRuseCellid = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.catgoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LHBRecommendCell class]) bundle:nil] forCellReuseIdentifier:leftRuseCellid];
    
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = LHBRGBColor(223, 223, 223);
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSMutableDictionary *pramDic = [NSMutableDictionary dictionary];
    pramDic[@"a"] = @"category";
    pramDic[@"c"] = @"subscribe";
    
    [manger GET:@"http://api.budejie.com/api/api_open.php" parameters:pramDic progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        //responseObject[@"lsit"]
        self.leftDataArr = [LHBRecommendModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        [self.catgoryTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LHBRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:leftRuseCellid];
//    cell.categroy = self.leftDataArr[indexPath.row];
    
//    LHBRecommendModel *modle = self.leftDataArr[indexPath.row];
//    cell.textLabel.text = modle.name;
//
    LHBRecommendModel *model = self.leftDataArr[indexPath.row];
    
    cell.categroy = model;//????
    return cell;
}











@end
