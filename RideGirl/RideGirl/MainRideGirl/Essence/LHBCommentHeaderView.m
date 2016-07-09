//
//  LHBCommentHeaderView.m
//  RideGirl
//
//  Created by LHB on 16/7/2.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBCommentHeaderView.h"

@interface LHBCommentHeaderView ()

@property (nonatomic,weak) UILabel *label;

@end

@implementation LHBCommentHeaderView

+ (instancetype)creatCommetHeaderView:(UITableView *)tableView
{
    static NSString *headerViewID = @"header";
    //先从缓存池中找header
    LHBCommentHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
    
    if (headerView == nil) {
        //没有headerView，自己创建一个
        headerView = [[LHBCommentHeaderView alloc] initWithReuseIdentifier:headerViewID];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = LHBGlobalColor;
        //创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = LHBRGBColor(67, 67, 67);
        label.x = LHBMARGIN;
        label.font = [UIFont systemFontOfSize:14.0];
        label.width = 200;
        //不能这样设置
        //label.text = self.title;
        //跟着父控件高度伸缩
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.label.text = title;
}

@end
