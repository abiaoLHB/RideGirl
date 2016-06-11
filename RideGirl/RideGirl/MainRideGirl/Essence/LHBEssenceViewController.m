//
//  LHBEssenceViewController.m
//  RideGirl
//
//  Created by LHB on 16/5/31.
//  Copyright © 2016年 LHB. All rights reserved.
//
#import "LHBRecommendTagsTableViewController.h"
#import "LHBEssenceViewController.h"
#import "LHBAllViewController.h"
#import "LHBVideoViewController.h"
#import "LHBVoiceViewController.h"
#import "LHBPictureViewController.h"
#import "LHBWordViewController.h"


@interface LHBEssenceViewController ()<UIScrollViewDelegate>
//底部指示器view
@property (nonatomic,weak) UIView *indicatorView;
//当前选中的button
@property (nonatomic,strong) UIButton *selectBtn;

@property (nonatomic,strong) UIView *titlesView;

@property (nonatomic,strong) UIScrollView *contentView;

@end

@implementation LHBEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setuChildVces];
    [self setupTitlesView];
    [self setupContentView];
}
#pragma mark - 初始化导航条
- (void)setupNav
{
    //设置精华控制器的导航条
    //initWithImage的好处就是和图片尺寸大小一致
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageNormalName:@"MainTagSubIcon" andHeightLightImageName:@"MainTagSubIconClick" target:self andAction:@selector(leftTagsClick)];
    self.view.backgroundColor = LHBRGBColor(223, 223, 233);
}
- (void)setupTitlesView
{
    //标签栏整体
    
    UIView *titlesView = [[UIView alloc] init];
    //半透明方案一
    //titlesView.backgroundColor =[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    //半透明方案二
    //titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    //半透明防范三
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    //不推荐方案(里面所有的子控件都会半透明)
    //titlesView.alpha = 0.5;
    titlesView.width = self.view.width;
    titlesView.height = LHBTitlesViewH;
    titlesView.y = LHBTitlesViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
  
    //底部指示器view(放到前面，后面可以使用它的尺寸)
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    //内部的子控件
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    for (NSInteger i=0; i<titles.count; i++) {
        UIButton *button = [[UIButton alloc]  init];
        button.height = height;
        button.width = width;
        button.tag = i;
        button.x = i * width;
        [button setTitle:titles[i] forState:UIControlStateNormal];
//        强制布局（强制更新子控件的frame，此时就可以拿到真正的fram）
//        [button layoutIfNeeded];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titilBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        //默认点击了第一个按钮
        if (i==0) {
//            indicatorView会慢慢变长
//            [self titilBtnClick:button];
            
            button.enabled = NO;
            self.selectBtn = button;
            
            //让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
             self.indicatorView.width = button.titleLabel.width;
            //或者
            //self.indicatorView.width = [titles[i] sizeWithAttributes:@{NSFontAttributeName : button.titleLabel.font}].width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    //防止滑动是吧indicatorView当成五个按钮中的某个按钮访问
    [titlesView addSubview:indicatorView];
}

- (void)titilBtnClick:(UIButton *)button
{
//    单选切换（在这里被点中的按钮还能被多次点击，改变了颜色。不符合要求）
//    self.selectBtn.selected = NO;
//    button.selected = YES;
//    self.selectBtn = button;
    
    self.selectBtn.enabled = YES;
    button.enabled = NO;
    self.selectBtn = button;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

#pragma mark - 初始化底部的scrollView
- (void)setupContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    //没用addsubView，因为要用到titllsView的高度，而这时titilVew还没创建好
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    //初始化完毕后默认加载第一个控制器
    [self scrollViewDidEndScrollingAnimation:contentView];
}

#pragma mark - 初始化5个控制器
- (void)setuChildVces
{
    LHBAllViewController *allVc = [[LHBAllViewController alloc] init];
    [self addChildViewController:allVc];
    
    LHBVideoViewController *videoVc = [[LHBVideoViewController alloc] init];
    [self addChildViewController:videoVc];
    
    LHBVoiceViewController *voiceVc = [[LHBVoiceViewController alloc] init];
    [self addChildViewController:voiceVc];
    
    LHBPictureViewController *pictureVc = [[LHBPictureViewController alloc] init];
    [self addChildViewController:pictureVc];
    
    LHBWordViewController *wordVc = [[LHBWordViewController alloc] init];
    [self addChildViewController:wordVc];
}

- (void)leftTagsClick
{
    LHBRecommendTagsTableViewController *tags = [[LHBRecommendTagsTableViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}



#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    //停止滚动后，加载控制器的view
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;//设置控制器view的y值为0，默认是20
    vc.view.height = scrollView.height;// 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    [scrollView addSubview:vc.view];
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titilBtnClick:self.titlesView.subviews[index]];
}










#pragma mark - 知识点
- (void)zhishidian
{
    
    //    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [leftBtn setBackgroundImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    //    [leftBtn setBackgroundImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    //    leftBtn.size = leftBtn.currentBackgroundImage.size;
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    //纯文字情况下可以设置文字并添加事件
    //    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:<#(nullable NSString *)#> style:<#(UIBarButtonItemStyle)#> target:<#(nullable id)#> action:(nullable SEL)];

}



@end
