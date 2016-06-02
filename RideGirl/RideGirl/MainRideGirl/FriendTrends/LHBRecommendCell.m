//
//  LHBRecommendCell.m
//  RideGirl
//
//  Created by LHB on 16/6/1.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBRecommendCell.h"
#import "LHBRecommendModel.h"

@interface LHBRecommendCell ()


@property (weak, nonatomic) IBOutlet UIView *leftSelectView;

@end

@implementation LHBRecommendCell

- (void)awakeFromNib
{
    self.backgroundColor = LHBRGBColor(244, 244, 244);
//    self.textLabel.textColor = LHBRGBColor(78, 78, 78);
    //高亮颜色。当cell选中的时候，内部所有子控件都会进入高亮状态.当cell的选中状态为none时，即使选中这个cell，内部子控件也不会进入高亮状态 
//    self.textLabel.highlightedTextColor = [UIColor yellowColor];//LHBRGBColor(219, 21, 26);
}

- (void)setCategroy:(LHBRecommendModel *)categroy
{
    _categroy = categroy;
    self.textLabel.text  = categroy.name;
}

//
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.height = self.contentView.height - 2;
}
//重写selected方法，当cell选中的时时，调用次方法，并传一个yes进来
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.leftSelectView.hidden = !selected;
    
    if (selected) {
         self.textLabel.textColor = [UIColor blueColor];
    }else{
        self.textLabel.textColor = LHBRGBColor(78, 78, 78);
    }
}

@end
