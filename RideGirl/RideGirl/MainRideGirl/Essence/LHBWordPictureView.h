//
//  LHBWordPictureView.h
//  RideGirl
//
//  Created by LHB on 16/6/15.
//  Copyright © 2016年 LHB. All rights reserved.
//  帖子－－图片类中间的图描述

#import <UIKit/UIKit.h>

@class LHBWordModel;

@interface LHBWordPictureView : UIView

+ (instancetype)creatLHBWordPictureView;

@property (nonatomic,strong) LHBWordModel *wordModel;

@end
