//
//  LHBWordPictureView.m
//  RideGirl
//
//  Created by LHB on 16/6/15.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBWordPictureView.h"
#import <SDWebImage/UIImageView+WebCache.h>
//#import <DACircularProgress/DALabeledCircularProgressView.h>
//包装后
#import "LHBProgressView.h"
#import "LHBShowPictureViewController.h"
#import "LHBWordModel.h"
@interface LHBWordPictureView ()


@property (weak, nonatomic) IBOutlet UIImageView *wordPicture;
@property (weak, nonatomic) IBOutlet UIImageView *gitImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigBtn;
@property (weak, nonatomic) IBOutlet LHBProgressView *progressView;

@end

@implementation LHBWordPictureView

- (void)awakeFromNib
{
    //关掉自动布局
    //如果明明把尺寸设置对了，然而却不是想要的效果，一般都是autoresizing的伸缩属性影响了。导致宽度变来变去
    self.autoresizingMask = UIViewAutoresizingNone;
    //设置进度条控件的圆角(包装后写到自己的类里去)
//    self.progressView.roundedCorners = 2.0;
//    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
    //图片能点击，看大图或者保存操作
    //imageView默认是不接受事件的，会穿透传给后面的控件。
    self.wordPicture.userInteractionEnabled = YES;
    [self.wordPicture addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
   
}
//点击cell上的图片(让显示大图按钮也能调用这个方法)
//另一做法，就是让这个显示大图按钮不能被点击，不是设置enabled = no,这样回事按钮图片状态发生改变。而是要设置userInteractionEnabled的状态＝NO，不改变按钮颜色。
- (IBAction)showPicture
{
    LHBShowPictureViewController *showPictureVC = [[LHBShowPictureViewController alloc] init];
    //model进去，这里是view，不是控制器，没有present方法。可以拿到window的控制器，来model，这样在app的任何地方都能model
    showPictureVC.wordModel = self.wordModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPictureVC animated:YES completion:nil];
}


+ (instancetype)creatLHBWordPictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setWordModel:(LHBWordModel *)wordModel
{
    _wordModel = wordModel;
    
    // 立马显示最新的进度值（防止因为网速慢，导致显示其他cell的进度值）
    [self.progressView setProgress:wordModel.imageViewProgress animated:NO];
    
    //iOS默认是不支持gif的，sdWebImage默认做了这件事情。零用iamgeIO框架解析成N个iamge对象,利用animationImages对象播放
    //如果需要显示进度条的话，就不要用这个方法了
//    [self.wordPicture sd_setImageWithURL:[NSURL URLWithString:wordModel.large_image] placeholderImage:nil];
    [self.wordPicture sd_setImageWithURL:[NSURL URLWithString:wordModel.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {//频繁调用
        //进度条
        self.progressView.hidden = NO;
        //算进度
        wordModel.imageViewProgress = 1.0 * receivedSize / expectedSize;
    
        [self.progressView setProgress:wordModel.imageViewProgress animated:NO];
//        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%d%%",(int)(progress * 100)];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //下载完以后，进度条控件应该隐藏
        self.progressView.hidden = YES;
    }];
    
    
    //如果是gif还得显示gif小图标
    //拿到这张图片的扩展名
    NSString *extension = wordModel.large_image.pathExtension;
    self.gitImageView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];//lowercaseString ---> 不管你扩展名是大小写，都转化成小写
    /*
     *最精确的判断：在不知道扩展名的情况下，如何知道图片的真实类型？取出图片的第一个字节，就可以判断出图片的真实类型
     + (NSString *)sd_contentTypeForImageData:(NSData *)data {
     uint8_t c;
     [data getBytes:&c length:1];
     switch (c) {
     case 0xFF:
     return @"image/jpeg";
     case 0x89:
     return @"image/png";
     case 0x47:
     return @"image/gif";
     case 0x49:
     case 0x4D:
     return @"image/tiff";
     case 0x52:
     /
     */
    //是否要现实图片上的大按钮(不太靠谱，model中又加了一个属性)
//    if (wordModel.imageFrame.size.height > LHBWordPictureMaxH  ) {
//        self.seeBigBtn.hidden = NO;
//    }else{
//        self.seeBigBtn.hidden = YES;
//    }
    if (wordModel.isBigPicture) {//大图
        self.seeBigBtn.hidden = NO;
        //设置图片的填充模式
        self.wordPicture.contentMode = UIViewContentModeScaleAspectFill;//图片从上到下填充imageView，超出的不现实
        //UIViewContentModeScaleAspectFit  宽高和真实图片一样，但能保证看到全部
        //在勾选xib的clip subViews 剪掉不需要的
//        self.wordPicture.clipsToBounds = YES;
        
    }else{//小图
        self.seeBigBtn.hidden = YES;
        self.wordPicture.contentMode = UIViewContentModeScaleToFill;
    }
}

@end
