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
