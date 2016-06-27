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
#import "LHBWordPictureView.h"
#import "LHBWordVoiceView.h"

@interface LHBWordTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *sina_vImageView;
@property (weak, nonatomic) IBOutlet UILabel *detalTextLabel;

//图片帖子中间的view
@property (nonatomic,weak) LHBWordPictureView  *pictureView;

//声音帖子中间的view
@property (nonatomic,weak) LHBWordVoiceView *voiceView;



@end

@implementation LHBWordTableViewCell

- (LHBWordPictureView *)pictureView
{
    if (_pictureView == nil) {
        LHBWordPictureView  *pictureView = [LHBWordPictureView creatLHBWordPictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (LHBWordVoiceView *)voiceView
{
    if (_voiceView == nil) {
        LHBWordVoiceView *voiceView = [LHBWordVoiceView creatLHBVoicePictureView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

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
    
    self.detalTextLabel.text = wordModel.text;
    
    [self setButtonTitle:self.dingBtn count:wordModel.ding placeholdStr:@"顶"];
    [self setButtonTitle:self.caiBtn count:wordModel.cai placeholdStr:@"踩"];
    [self setButtonTitle:self.shareBtn count:wordModel.repost placeholdStr:@"分享"];
    [self setButtonTitle:self.commentBtn count:wordModel.comment placeholdStr:@"评论"];
    
    //中间时图片
    if (wordModel.type == LHBWordTypePicture) {
        self.pictureView.wordModel = wordModel;
        self.pictureView.frame = wordModel.imageFrame;
    }else if (wordModel.type == LHBWordTypeVoice){
        self.voiceView.wordModel = wordModel;
        self.voiceView.frame = wordModel.voiceFrame;
    
    }

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
