//
//  LHBWordVideoView.m
//  RideGirl
//
//  Created by LHB on 16/6/28.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBWordVideoView.h"
#import "LHBWordModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LHBShowPictureViewController.h"

@interface LHBWordVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;

@end

@implementation LHBWordVideoView

+ (instancetype)creatLHBVideoView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
    
}
//点击cell上的图片(让显示大图按钮也能调用这个方法)
//另一做法，就是让这个显示大图按钮不能被点击，不是设置enabled = no,这样回事按钮图片状态发生改变。而是要设置userInteractionEnabled的状态＝NO，不改变按钮颜色。
- (void)showPicture
{
    LHBShowPictureViewController *showPictureVC = [[LHBShowPictureViewController alloc] init];
    //model进去，这里是view，不是控制器，没有present方法。可以拿到window的控制器，来model，这样在app的任何地方都能model
    showPictureVC.wordModel = self.wordModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPictureVC animated:YES completion:nil];
}

- (void)setWordModel:(LHBWordModel *)wordModel
{
    _wordModel = wordModel;
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:wordModel.large_image]];
    //播放次数
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",wordModel.playcount];
    //播放时长
    NSInteger minute = wordModel.videotime / 60;
    NSInteger second = wordModel.videotime % 60;
    //  2zd 保留2位，不足用0代替
    self.playTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

@end
