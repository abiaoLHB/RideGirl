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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(LHBRecommendTagsModel *)model
{
    _model = model;
    
    //设置头像
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image_list] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //看看有没有头像，没有就显示默认
        self.imageView.image = image ? [image circleImage] : placeholder;
    } ];
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


- (void)setFrame:(CGRect)frame
{
 //实现带有间隔的cell，有三种实现方案
//    1、在cell的contentView上放一个view，让这个view略小于contentView
//    2、直接改cell的contentView，让contentView往里面缩
//    3、本方法，直接更改cell的尺寸。一般用这个就行了
    frame.origin.x = 5;
    frame.size.width -= 2*frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
 
}

//如果不想让外部的数据改更一个控件的frame，就重写- (void)setFrame:(CGRect)frame方法
//如果不想让外部的数据改更一个控件的bounds，就重写- (void)setBounds:(CGRect)bounds方法




- (void)layoutSubviews
{
    self.imageView.x = LHBMARGIN;
    self.imageView.centerY = self.contentView.height * 0.5;
    self.imageView.width = 50;
    self.imageView.height = 50;
}

@end
