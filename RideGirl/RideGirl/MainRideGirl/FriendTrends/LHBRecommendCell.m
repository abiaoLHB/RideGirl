//
//  LHBRecommendCell.m
//  RideGirl
//
//  Created by LHB on 16/6/1.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBRecommendCell.h"
#import "LHBRecommendModel.h"

@implementation LHBRecommendCell

- (void)awakeFromNib
{
    self.backgroundColor = LHBRGBColor(244, 244, 244);
    
}

- (void)setCategroy:(LHBRecommendModel *)categroy
{
    _categroy = categroy;
    self.textLabel.text  = categroy.name;
}


@end
