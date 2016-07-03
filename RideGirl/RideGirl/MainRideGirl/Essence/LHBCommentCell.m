//
//  LHBCommentCell.m
//  RideGirl
//
//  Created by LHB on 16/7/2.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBCommentCell.h"
#import "LHBComment.h"
#import "LHBUser.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface LHBCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation LHBCommentCell

/**
 *  有资格成为第一响应者
 */
- (BOOL)canBecomeFirstResponder
{
    return YES;
}


/**
 *  不要返回一些系统的操作，我要自定义事件
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}


- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
    //弊端：如果对cell的图层做过多处理，会造成很卡，一般不这样。一般通过绘图的只是做出来：下载完正方形的头像图片后，进行处理，cell上直接显示圆形的图片
//    self.headerImageView.layer.cornerRadius = self.headerImageView.size.width * 0.5;
//    self.headerImageView.clipsToBounds = YES;

}

- (void)setCommentModel:(LHBComment *)commentModel
{
    _commentModel = commentModel;
    
    //设置头像，并坐远行处理
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:commentModel.user.profile_image] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //覆盖一下
        self.headerImageView.image =image ? [image circleImage] : placeholder;
    }];
    
    self.sexImageView.image = [commentModel.user.sex isEqualToString:LHBUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
      //xib中这个label设置了距离父控件底部为10的约束，然后又设置了一个至少22高度的约束。
    self.commentLabel.text = commentModel.content;
    self.userNameLabel.text = commentModel.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",commentModel.like_count];
    if (commentModel.voiceurl.length) {//防止空字符串 @""
        self.voiceButton.hidden = NO;
      
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",commentModel.voicetime] forState:UIControlStateNormal];
    }else{
        self.voiceButton.hidden = YES;
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;
    frame.size.width -= 20;
    
    [super setFrame:frame];
}

@end
