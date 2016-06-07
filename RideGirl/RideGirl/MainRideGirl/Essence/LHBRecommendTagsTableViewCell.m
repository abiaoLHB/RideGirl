//
//  LHBRecommendTagsTableViewCell.m
//  RideGirl
//
//  Created by LHB on 16/6/8.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBRecommendTagsTableViewCell.h"
#import "LHBRecommendTagsModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface LHBRecommendTagsTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageview;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumLabel;

@end

@implementation LHBRecommendTagsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(LHBRecommendTagsModel *)model
{
    _model = model;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.titleNameLabel.text = model.theme_name;
    
    NSString *subNumber = nil;
    if (model.sub_number<10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅",model.sub_number];
;
    }else{
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅",model.sub_number/10000.0];
    }
    self.subNumLabel.text = subNumber;
}
@end
