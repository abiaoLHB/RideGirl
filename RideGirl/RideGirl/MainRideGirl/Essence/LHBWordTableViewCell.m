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

@end

@implementation LHBWordTableViewCell

- (void)awakeFromNib
{
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgImageView;
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


- (void)setWordModel:(LHBWordModel *)wordModel
{
    _wordModel = wordModel;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:wordModel.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = wordModel.name;
    self.timeLabel.text = wordModel.create_time;
    
    LHBLog(@"%@",wordModel.create_time);
    
    [self testData:wordModel.create_time];
    
    
    [self setButtonTitle:self.dingBtn count:wordModel.ding placeholdStr:@"顶"];
    [self setButtonTitle:self.caiBtn count:wordModel.cai placeholdStr:@"踩"];
    [self setButtonTitle:self.shareBtn count:wordModel.repost placeholdStr:@"分享"];
    [self setButtonTitle:self.commentBtn count:wordModel.comment placeholdStr:@"评论"];

}

- (void)testData:(NSString *)creat_time
{
    //日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期格式
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //当前时间
    NSDate *now = [NSDate date];
    //发帖时间
    NSDate *creatTime = [fmt dateFromString:creat_time];
   
    
    LHBLog(@"%@",[now daltaFrom:creatTime] );
    
    
   
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
