//
//  LHBCommentViewController.m
//  RideGirl
//
//  Created by LHB on 16/7/1.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBCommentViewController.h"
#import "LHBWordTableViewCell.h"
#import "LHBWordModel.h"
#import <MJRefresh/MJRefresh.h>
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "LHBComment.h"
#import "LHBCommentHeaderView.h"


@interface LHBCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 *  底部间距，用来跟随键盘
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) AFHTTPSessionManager *manager;
//热门评论数据源
@property (nonatomic,strong) NSMutableArray *hotCommentsDataMutArr;
//最新评论数据源
@property (nonatomic,strong) NSMutableArray *latesCommentsDataMutArr;

@end

@implementation LHBCommentViewController

- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (NSMutableArray *)hotCommentsDataMutArr
{
    if (!_hotCommentsDataMutArr) {
        _hotCommentsDataMutArr = [NSMutableArray array];
    }
    return _hotCommentsDataMutArr;
}
- (NSMutableArray *)latesCommentsDataMutArr
{
    if (!_latesCommentsDataMutArr) {
        _latesCommentsDataMutArr = [NSMutableArray array];
    }
    return _latesCommentsDataMutArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBasic];
    [self creatTableViewHeader];
    [self setupRefresh];
}
- (void)creatBasic
{
    self.navigationItem.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageNormalName:@"comment_nav_item_share_icon" andHeightLightImageName:nil target:nil andAction:nil];
    //注册键盘弹出、隐藏通知。尽量用UIKeyboardWillChangeFrameNotification方法，因为既包含弹出，也包含隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.tableView.backgroundColor = LHBGlobalColor;
}


//让我的宽度等于父控件的宽度，并且父控件以后是多宽，我就是多宽
- (void)creatTableViewHeader
{
    //设置header
    UIView *headerView = [[UIView alloc] init];
    
    //往headerView上添加cell
    LHBWordTableViewCell *cell = [LHBWordTableViewCell creatWordTabelViewCell];
    cell.wordModel = self.wordModel;
    cell.size = CGSizeMake(LHBScreenW, self.wordModel.cellH);
    [headerView addSubview:cell];
    //headerView的高度
    headerView.height = self.wordModel.cellH + 10;
    
    //先设置frame和先设置HeaderView是有区别的！！先设置好headerView的高，在设置为tableHeaderView就没事.
    //直接拿一个cell当tableHeaderView会有各种各样的问题，因为cell高度为了满足cell的展示，高度都是算好的，而在拿cell当tableHeaderView ，高度就会改来改度的，一般做法是先包装一下，把cell放到一个view上，设置下frame就可以了
    self.tableView.tableHeaderView = headerView;
}
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    //一进来就刷新数据
    [self.tableView.mj_header beginRefreshing];
}
/**
 *  加载新数据
 */
- (void)loadNewComments
{
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"a"] = @"dataList";
    parm[@"c"] = @"comment";
    parm[@"data_id"] = self.wordModel.ID;
    parm[@"hot"] = @"1";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parm progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //最热评论
        self.hotCommentsDataMutArr = [LHBComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        //最新评论
        self.latesCommentsDataMutArr = [LHBComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        //刷新表格
        [self.tableView reloadData];
        
        //不管请求成功失败，都要结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        //不管请求成功失败，都要结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
    
}


/**
 *  返回第section组的评论数据
 */
- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotCommentsDataMutArr.count ? self.hotCommentsDataMutArr : self.latesCommentsDataMutArr;
    }
    return self.latesCommentsDataMutArr;
}
/**
 *  返回第几段第几行的评论
 */
- (LHBComment *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //返回几段不一定，因为有可能没有评论，也有可能没有最热评论
    NSInteger hotCount = self.hotCommentsDataMutArr.count;
    NSInteger latestCount = self.latesCommentsDataMutArr.count;
    
    if (hotCount) {//有最热评论＋最新评论
        return 2;
    }else if (latestCount){//只有最新评论
        return 1;
    }else{
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotCommentsDataMutArr.count;
    NSInteger latestCount = self.latesCommentsDataMutArr.count;
    
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    //非第0组
    return latestCount;
}

/**
 *  headerView的循环利用.未封装
 */
- (void)testHeaderResue
{
    //- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
    //{
    //    static NSString *headerViewID = @"header";
    //    //先从缓存池中找header
    //    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
    //
    //    UILabel *label = nil;
    //
    //    if (headerView == nil) {
    //        //没有headerView，自己创建一个
    //        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerViewID];
    //        //方法过期
    //        //headerView.backgroundColor = LHBGlobalColor;
    //        headerView.contentView.backgroundColor = LHBGlobalColor;
    //        //创建label
    //        label = [[UILabel alloc] init];
    //        label.textColor = LHBRGBColor(67, 67, 67);
    //        label.x = 10;
    //        label.font = [UIFont systemFontOfSize:14.0];
    //        label.width = 200;
    //        label.tag = SectionHeaderViewLabelTag;
    //        //跟着父控件高度伸缩
    //        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    //        [headerView.contentView addSubview:label];
    //    }else{
    //        label = (UILabel *)[headerView viewWithTag:SectionHeaderViewLabelTag];
    //    }
    //    //设置label的数据
    //    NSInteger hotCount = self.hotCommentsDataMutArr.count;
    //    if (section==0) {
    //        label.text = hotCount ? @"最热评论":@"最新评论";
    //    }else{
    //        label.text = @"最新评论";
    //    }
    //    return headerView;
    //    
    //}
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //支持注册
    //    tableView registerNib:<#(nullable UINib *)#> forHeaderFooterViewReuseIdentifier:<#(nonnull NSString *)#>

    LHBCommentHeaderView *headerView = [LHBCommentHeaderView creatCommetHeaderView:tableView];
    
    //设置label的数据
    NSInteger hotCount = self.hotCommentsDataMutArr.count;
    if (section==0) {
        headerView.title = hotCount ? @"最热评论":@"最新评论";
    }else{
        headerView.title = @"最新评论";
    }
    return headerView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    LHBComment *comment = [self commentInIndexPath:indexPath];
    cell.textLabel.text = comment.content;
    return cell;
}


/**
 *  键盘变化处理方法
 */
- (void)keyboardWillChangeFrame:(NSNotification *)noti
{
    //CGRectValue --> 对象转换成CGRectValue
    //键盘弹出、隐藏后的frame，即当前的frame(最后的frame)
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //直接这样写是不对的，因为即使键盘隐藏了，键盘的高度还是那么高
    //self.bottomSpace.constant = frame.size.height;
    
    //正确的做法是用屏幕的高度减去键盘的y值
    self.bottomSpace.constant = LHBScreenH - frame.origin.y;
    
    //键盘弹出时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //改完约束，强制布局一下，执行动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //实时监听 不太好,调用太频繁
    //- (void)scrollViewDidScroll:(UIScrollView *)scrollView
    [self.view endEditing:YES];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
