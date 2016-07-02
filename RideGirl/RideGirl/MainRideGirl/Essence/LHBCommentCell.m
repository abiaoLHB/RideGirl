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

- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setCommentModel:(LHBComment *)commentModel
{
    _commentModel = commentModel;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:commentModel.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
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
