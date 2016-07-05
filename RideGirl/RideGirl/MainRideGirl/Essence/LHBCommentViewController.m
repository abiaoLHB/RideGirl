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
#import "LHBCommentCell.h"

static NSString *const LHBCommentCellID = @"commentID";

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
//保存帖子的top_cmt,最热评论数组
@property (nonatomic,strong) NSArray *savedTopCmt;
/**当前页码*/
@property (nonatomic,assign) NSInteger currentPage;

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
     //iOS8以后的方法：让cell自动算高度。xib中，评论内容据父控件底部为10
    //简单的cell自动算就行了，复杂的尽量动态算
    //自动算的条件 缺一不可
    //条件一 给一个估计高度
    self.tableView.estimatedRowHeight = 44;
    //条件二 自动算  AutomaticDimension －> 自动尺寸
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //tableView内边距，让tableView底部距离工具条有点距离，显得好看
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LHBCommentCell class]) bundle:nil] forCellReuseIdentifier:LHBCommentCellID];
    
}


//让我的宽度等于父控件的宽度，并且父控件以后是多宽，我就是多宽
- (void)creatTableViewHeader
{
    //设置header
    UIView *headerView = [[UIView alloc] init];
    
    // 如果有热门评论，评论详情页面就不要在显示了
    if (self.wordModel.top_cmt.count) {
        //保存热门评论数组
        self.savedTopCmt = self.wordModel.top_cmt;
        //清空top_cmt
        self.wordModel.top_cmt = nil;
        //readOnlay,通过kvc改
        [self.wordModel setValue:@0 forKey:@"cellH"];
    }
    
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
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreCommets)];
    //因为是从xib加载的tableView，所有刚进来不走数据源方法，根据数据长度来判断foot是否不行。这里硬性隐藏
    self.tableView.mj_footer.hidden = YES;
}
/**
 *  加载新数据
 */
- (void)loadNewComments
{
    //结束之前的请求，防止刷新、加载一起搞
    //tasks数组中的所有任务都取消操作。任务取消会来到failure方法
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"a"] = @"dataList";
    parm[@"c"] = @"comment";
    parm[@"data_id"] = self.wordModel.ID;
    parm[@"hot"] = @"1";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parm progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //有时会给个数组，新帖中返回的就是数组，这里要是数组一定要return
        if (![responseObject isKindOfClass:[NSDictionary class]] ) {
            [self.tableView.mj_header endEditing:YES];
            return ;
        }
        
        //最热评论
        self.hotCommentsDataMutArr = [LHBComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        //最新评论
        self.latesCommentsDataMutArr = [LHBComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        //下拉刷新成功，回到第一页
        self.currentPage = 1;
        
        //刷新表格
        [self.tableView reloadData];
        
        //不管请求成功失败，都要结束刷新
        [self.tableView.mj_header endRefreshing];
        
        //控制footer状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latesCommentsDataMutArr.count >= total) {//百思的total不太准
            self.tableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        //不管请求成功失败，都要结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
    
}
/**
 *  加载更多数据
 */
- (void)loadMoreCommets
{
    //结束之前的请求，防止刷新、加载一起搞
    //tasks数组中的所有任务都取消操作。任务取消会来到failure方法
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //取出当前页码页码
    NSInteger page = self.currentPage;
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"a"] = @"dataList";
    parm[@"c"] = @"comment";
    parm[@"data_id"] = self.wordModel.ID;
    parm[@"page"] = @(page);
    
    LHBComment *cmt = self.latesCommentsDataMutArr.lastObject;
    parm[@"lastcid"] = cmt.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parm progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //有时会给个数组，新帖中返回的就是数组，这里要是数组一定要return
        if (![responseObject isKindOfClass:[NSDictionary class]] ) {
            [self.tableView.mj_header endEditing:YES];

            return ;
        }
        //最新评论
        NSArray *newCommentsDataArr = [LHBComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latesCommentsDataMutArr addObjectsFromArray:newCommentsDataArr];
        
        //加载成功，页码才加1
        self.currentPage = page + 1;
        
        //刷新表格
        [self.tableView reloadData];
        
        //控制footer状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latesCommentsDataMutArr.count >= total) {//百思的total不太准
            self.tableView.mj_footer.hidden = YES;
        }else{
            //不管请求成功失败，都要结束刷新
            [self.tableView.mj_footer endRefreshing];
            self.currentPage = page;
        }
        
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
    //隐藏更多控件
    tableView.mj_footer.hidden = (latestCount == 0);
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
    
    LHBCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:LHBCommentCellID];
    cell.commentModel = [self commentInIndexPath:indexPath];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建menu菜单
    UIMenuController *menu = [UIMenuController sharedMenuController];
    //这样显示在cell的顶部
    //[menu setTargetRect:cell.bounds inView:cell];
    
    //当点击的cell不再是第一响应者的时候，menu会自动消失
    if (menu.isMenuVisible) {//正在显示
        [menu setMenuVisible:NO animated:YES];
        return;
    }
    
    //被点击的cell
    LHBCommentCell *cell = (LHBCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
    //让cell的控制器成为响应着
    [cell becomeFirstResponder];
    
   
    
    //显示中间
    CGRect menuRect = CGRectMake(0, cell.height*0.5, cell.width, cell.height*0.5);
    [menu setTargetRect:menuRect inView:cell];
    
    UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
    UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
    UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
    //当menu要在别的控制器现实的时候，要清除掉这个数组
    menu.menuItems = @[ding,replay,report];
    
    //通过动画出来
    [menu setMenuVisible:YES animated:YES];
}
#pragma mark - MenuConotroller 处理
/**
 *  顶
 */
- (void)ding:(UIMenuController *)meun
{
    //顶哪一行评论
    //虽然这个cell的selecd ＝ none了，但是还是会记着这个行号的，也就是说这个cell还是选中了，只是看不见选中的样式而已
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    
    NSLog(@"ding,%zd",indexPath.row);
}

/**
 *  顶
 */
- (void)replay:(UIMenuController *)meun
{
    NSLog(@"replay");
}

/**
 *  举报
 */
- (void)report:(UIMenuController *)meun
{
    NSLog(@"report");
}


#pragma mark - 键盘变化处理方法
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
    
    
    //一准备滑动就让menu消失
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuVisible:NO animated:YES];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //恢复帖子的top_cmt
    if (self.savedTopCmt.count) {
        self.wordModel.top_cmt = self.savedTopCmt;
        //重算一遍
        //kvc会自动找cellH这个属性，没有在找 _cellH 这个成员变量
        [self.wordModel setValue:@0 forKey:@"cellH"];
    }
    
    //取消所有任务 防止控制器死掉，求情数据还回来造成坏内存访问
    //[self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager invalidateSessionCancelingTasks:YES];

}

@end
