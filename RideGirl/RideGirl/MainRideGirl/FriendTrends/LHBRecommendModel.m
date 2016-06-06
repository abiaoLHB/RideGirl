//
//  LHBRecommendModel.m
//  RideGirl
//
//  Created by LHB on 16/6/1.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBRecommendModel.h"

@implementation LHBRecommendModel

- (NSMutableArray *)leftModelDataArr
{
    if (_leftModelDataArr == nil) {
        _leftModelDataArr = [NSMutableArray array];
    }
    return _leftModelDataArr;
}

@end
