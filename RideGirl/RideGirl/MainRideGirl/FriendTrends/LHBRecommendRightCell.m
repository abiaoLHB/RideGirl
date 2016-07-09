//
//  LHBRecommendRightCell.m
//  RideGirl
//
//  Created by LHB on 16/6/2.
//  Copyright © 2016年 LHB. All rights reserved.
//  推荐关注的view

#import "LHBRecommendRightCell.h"
#import "LHBRecommendRightModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation LHBRecommendRightCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setRightModel:(LHBRecommendRightModel *)rightModel
{
    _rightModel = rightModel;
    self.nameLbel.text = rightModel.screen_name;
    //设置头像
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];

    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:rightModel.header] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //看看有没有头像，没有就显示默认
        self.headerImageView.image = image ? [image circleImage] : placeholder;
    } ];
    
    self.fanseLabel.text =[NSString stringWithFormat:@"%zd人关注",rightModel.fans_count];
}
@end
