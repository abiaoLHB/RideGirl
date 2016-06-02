//
//  LHBRecommendRightCell.m
//  RideGirl
//
//  Created by LHB on 16/6/2.
//  Copyright © 2016年 LHB. All rights reserved.
//

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
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:rightModel.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.fanseLabel.text =[NSString stringWithFormat:@"%zd人关注",rightModel.fans_count];
}
@end
