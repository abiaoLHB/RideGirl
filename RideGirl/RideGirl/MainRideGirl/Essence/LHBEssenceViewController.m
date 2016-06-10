//
//  LHBEssenceViewController.m
//  RideGirl
//
//  Created by LHB on 16/5/31.
//  Copyright © 2016年 LHB. All rights reserved.
//
#import "LHBRecommendTagsTableViewController.h"
#import "LHBEssenceViewController.h"

@interface LHBEssenceViewController ()
//底部指示器view
@property (nonatomic,weak) UIView *indicatorView;
//当前选中的button
@property (nonatomic,strong) UIButton *selectBtn;


@end

@implementation LHBEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupTitlesView];
    
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
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    //不推荐方案(里面所有的子控件都会半透明)
    //titlesView.alpha = 0.5;
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 64;
    [self.view addSubview:titlesView];
  
    //底部指示器view(放到前面，后面可以使用它的尺寸)
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    //内部的子控件
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    for (NSInteger i=0; i<titles.count; i++) {
        UIButton *button = [[UIButton alloc]  init];
        button.height = height;
        button.width = width;
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
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    
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
}


- (void)leftTagsClick
{
    LHBRecommendTagsTableViewController *tags = [[LHBRecommendTagsTableViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
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
