//
//  LHBShowPictureViewController.m
//  RideGirl
//
//  Created by LHB on 16/6/22.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBShowPictureViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "LHBProgressView.h"
#import "LHBWordModel.h"

@interface LHBShowPictureViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic)  UIImageView *imageView;

@property (weak, nonatomic) IBOutlet LHBProgressView *progressView;

@end
/*
  在xib中，一般只有uiview、uiscrollView、uitableView等可以添加子控件，想uiimageView不可以网上拖子控件，因为苹果不建议这么干。因为像uiimageView功能比价专一，就是用来显示图片的。要想搞一个父控件张装子控件，请搞一个uiview等。
 */
@implementation LHBShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //屏幕尺寸
    CGFloat screenH = [[UIScreen mainScreen] bounds].size.height;
    CGFloat screenW = [[UIScreen mainScreen] bounds].size.width;
    
    //添加图片
    //因为图片大小、位置都不确定，别再xib里面添加了，代码添加
    UIImageView *imageView =[[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    //图片尺寸
    CGFloat pictureW = screenW;
    CGFloat pictureH = pictureW * self.wordModel.height / self.wordModel.width;
    
    if (pictureH > screenH) {//图片高度超过一个屏幕，需要滚动查看
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }else{
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = screenH * 0.5;
    }
    
    
    //马上显示当前图片的下载进度
    [self.progressView setProgress:self.wordModel.imageViewProgress animated:YES];
    
    
//    [imageView sd_setImageWithURL:[NSURL URLWithString:self.wordModel.large_image]];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.wordModel.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //网速慢时就不会调用这个block，意味着进度值没有在改
        self.progressView.hidden = NO;
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];

        //这个方法只会调用一次，因为sdWebImage会以图片的url作为key创建一个option对象，一个图片之后下载一次。如果在上一级页面中（没有点击图片进入大图之前那个页面），那个图片下载多少，这里就下载多少
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}
- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//保存图片
- (IBAction)saveImage {
    
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片还没有下载完毕！"];
        return;
    }
    //将图片写入相册(第一次调用此方法时，苹果会自动弹框 要访问你相册，同不同意)
    //后面三个参数的含义是（加入是ABC）：保存完毕A就会调用第二个B的方法，并传递一个参数c
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
//- (void)saveSucess
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];

    }
}
/*
 用UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(saveSucess), nil);方法保存成功，还会崩溃的原因：
 reason: '-[NSInvocation setArgument:atIndex:]: index (2) out of bounds [-1, 1]'
 原因：NSInvocation是回调，Argument是越界。方法参数越界，也就是这个方法提供的参数不够。所以此时的这个@selector(saveSucess)不能乱写，得有一个它传给你的参数。所以此时保存成功方法最好用苹果给你提供的方法
 
 delelop
 */


@end
