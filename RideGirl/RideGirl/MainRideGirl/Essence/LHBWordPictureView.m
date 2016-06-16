//
//  LHBWordPictureView.m
//  RideGirl
//
//  Created by LHB on 16/6/15.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBWordPictureView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LHBWordModel.h"
@interface LHBWordPictureView ()


@property (weak, nonatomic) IBOutlet UIImageView *wordPicture;
@property (weak, nonatomic) IBOutlet UIImageView *gitImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigBtn;

@end

@implementation LHBWordPictureView

- (void)awakeFromNib
{
    //关掉自动布局
    //如果明明把尺寸设置对了，然而却不是想要的效果，一般都是autoresizing的伸缩属性影响了。导致宽度变来变去
    self.autoresizingMask = UIViewAutoresizingNone;
}

+ (instancetype)creatLHBWordPictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setWordModel:(LHBWordModel *)wordModel
{
    _wordModel = wordModel;
    
    //iOS默认是不支持gif的，sdWebImage默认做了这件事情。零用iamgeIO框架解析成N个iamge对象,利用animationImages对象播放
    [self.wordPicture sd_setImageWithURL:[NSURL URLWithString:wordModel.large_image] placeholderImage:nil];
}

@end
