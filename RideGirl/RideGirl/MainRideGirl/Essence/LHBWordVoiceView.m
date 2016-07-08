//
//  LHBWordVoiceView.m
//  RideGirl
//
//  Created by LHB on 16/6/27.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBWordVoiceView.h"
#import "LHBWordModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LHBShowPictureViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface LHBWordVoiceView ()<AVAudioPlayerDelegate>
{
    AVAudioPlayer *_avAudioPlayer;
    UIProgressView *_progressView;
    UISlider *_volumeslider;
    NSTimer *_timer;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;


@end

@implementation LHBWordVoiceView

+ (instancetype)creatLHBVoicePictureView
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
    NSInteger minute = wordModel.voicetime / 60;
    NSInteger second = wordModel.voicetime % 60;
    //  2zd 保留2位，不足用0代替
    self.playLengthLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

- (IBAction)playVoiceClick:(LHBVoicePlayBtn *)sender
{
    UITabBarController *tabBarVC = (UITabBarController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    UINavigationController *nav = tabBarVC.selectedViewController;
    
    //要知道点击了那个模型
    NSString *urlStr = sender.wordModel.weixin_url;
    //用一个音频URL初始化音频播放器
    _avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:urlStr] error:nil];
    //设置代理
    _avAudioPlayer.delegate = self;
    //初始音量
    _avAudioPlayer.volume = 1.0;
    // 单曲循环
    _avAudioPlayer.numberOfLoops = -1;
    //预播放
    [_avAudioPlayer prepareToPlay];
    
   
}

//改变播放进度
- (void)playProgress
{
    LHBLogFunc;
}
//改变音量
- (void)volumeChange
{
    LHBLogFunc;
}

@end
