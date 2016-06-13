//
//  LHBWordTableViewCell.m
//  RideGirl
//
//  Created by LHB on 16/6/12.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBWordTableViewCell.h"
#import "LHBWordModel.h"
#import "NSDate+LHBDateExtension.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LHBWordTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *sina_vImageView;

@end

@implementation LHBWordTableViewCell

- (void)awakeFromNib
{
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgImageView;

    self.headerImageView.layer.cornerRadius = self.headerImageView.size.width*0.5;
    self.headerImageView.clipsToBounds = YES;

}



- (void)setFrame:(CGRect)frame
{
    static CGFloat margin = 10;
    frame.origin.x = margin;
    frame.origin.y += margin;
    frame.size.width -= margin * 2;
    frame.size.height -= margin;
    [super setFrame:frame];
}

/**
 今年
 今天
 1分钟内
 刚刚
 1小时内
 xx分钟前
 其他
 xx小时前
 昨天
 昨天 18:56:34
 其他
 06-23 19:56:23
 
 非今年
 2014-05-08 18:45:30
 */
- (void)setWordModel:(LHBWordModel *)wordModel
{
    _wordModel = wordModel;
    //设置头像
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:wordModel.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置名字
    self.nameLabel.text = wordModel.name;
    //设置帖子的创建时间
    self.timeLabel.text = wordModel.create_time;
    
    self.sina_vImageView.hidden = !wordModel.sina_v;
    
    
    [self setButtonTitle:self.dingBtn count:wordModel.ding placeholdStr:@"顶"];
    [self setButtonTitle:self.caiBtn count:wordModel.cai placeholdStr:@"踩"];
    [self setButtonTitle:self.shareBtn count:wordModel.repost placeholdStr:@"分享"];
    [self setButtonTitle:self.commentBtn count:wordModel.comment placeholdStr:@"评论"];

}

- (void)testData:(NSString *)creat_time
{
    
    
    
    
    
   
}


- (void)setButtonTitle:(UIButton *)btn count:(NSInteger)count placeholdStr:(NSString *)placeholdStr
{
    if (count >10000) {
        placeholdStr = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }else if(count >0){
        placeholdStr = [NSString stringWithFormat:@"%zd",count];
    }
    [btn setTitle:placeholdStr forState:UIControlStateNormal];
}


@end
