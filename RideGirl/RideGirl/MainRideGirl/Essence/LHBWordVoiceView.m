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

@interface LHBWordVoiceView ()

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
@end
