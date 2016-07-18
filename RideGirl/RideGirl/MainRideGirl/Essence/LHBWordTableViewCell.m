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
#import "LHBWordVideoView.h"
//评论模型
#import "LHBComment.h"
//包含用户模型
#import "LHBUser.h"

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

//视频帖子中间的view
@property (nonatomic,weak) LHBWordVideoView *videoView;
//热门评论内容
@property (weak, nonatomic) IBOutlet UILabel *topCmtCommentLabel;
//热门评论父控件
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@end

@implementation LHBWordTableViewCell

+ (instancetype)creatWordTabelViewCell
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

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
        _voiceView = voiceView;//0 0; 306 264
    }
    return _voiceView;
}

- (LHBWordVideoView *)videoView
{
    if (_videoView == nil) {
        LHBWordVideoView *videoView = [LHBWordVideoView creatLHBVideoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;//0 0; 277 228
    }
    return _videoView;
}

- (void)awakeFromNib
{
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgImageView;
    
    //弊端：如果对cell的图层做过多处理，会造成很卡，一般不这样。一般通过绘图的只是做出来：下载完正方形的头像图片后，进行处理，cell上直接显示圆形的图片
//    self.headerImageView.layer.cornerRadius = self.headerImageView.size.width*0.5;
//    self.headerImageView.clipsToBounds = YES;
}



- (void)setFrame:(CGRect)frame
{
    static CGFloat margin = LHBMARGIN;
    frame.origin.x = margin;
    frame.origin.y += margin;
    frame.size.width -= margin * 2;
    //这个高度这样减的话，如果有tableHeaderView的话，会导致tableHeaderView的frame递减
    //frame.size.height -= margin;
    //用这个方法，就是用算出来cell的高度剪去一个间距，也是cell的真实高度，不会导致tableHeaderView的frame递减
    frame.size.height = self.wordModel.cellH - LHBMARGIN;
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
    //设置头像 占位图片也是圆的了
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];

    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:wordModel.profile_image] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.headerImageView.image = image ?[image circleImage] : placeholder;
    }];
    
    
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
    //hidden的yes、no是处理cell复用的
    if (wordModel.type == LHBWordTypePicture) {//图片
        self.pictureView.hidden = NO;
        self.pictureView.wordModel = wordModel;
        self.pictureView.frame = wordModel.imageFrame;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }else if (wordModel.type == LHBWordTypeVoice){//音频
        self.voiceView.hidden = NO;
        self.voiceView.wordModel = wordModel;
        self.voiceView.voicePlayBtn.wordModel = wordModel;
        //(origin = (x = 0, y = 0), size = (width = 306, height = 264))
        self.voiceView.frame = wordModel.voiceFrame;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (wordModel.type == LHBWordTypeVideo){//视频
        self.videoView.hidden = NO;
        self.videoView.wordModel = wordModel;
        //给播放视频按钮绑定一个模型
        self.videoView.videoPlayButton.wordModel = wordModel;
        //(origin = (x = 0, y = 0), size = (width = 277, height = 228))
        self.videoView.frame = wordModel.videoFrame;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    }else{//段子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    //设置热门评论
    //从评论模型数组里取出第一个评论
    LHBComment *cmtModel = wordModel.top_cmt.firstObject;
    if (cmtModel) {//如果这个模型有值，说明是有热门评论的
        self.topCmtView.hidden = NO;
        //取出具体评论内容,并拼接上用户名
        self.topCmtCommentLabel.text = [NSString stringWithFormat:@"%@ : %@",cmtModel.user.username,cmtModel.content];
    }else{
        self.topCmtView.hidden = YES;
    }
}


- (void)setButtonTitle:(UIButton *)btn count:(NSInteger)count placeholdStr:(NSString *)placeholdStr
{
    if (count > 10000) {
        placeholdStr = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }else if(count >0){
        placeholdStr = [NSString stringWithFormat:@"%zd",count];
    }
    [btn setTitle:placeholdStr forState:UIControlStateNormal];
}
/**
 *  cell右上角更多按钮
 */
- (IBAction)more {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
    [sheet showInView:self.window];
    
}

@end
