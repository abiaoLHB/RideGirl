//
//  LHBWordVideoView.h
//  RideGirl
//
//  Created by LHB on 16/6/28.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHBWordModel;

@interface LHBWordVideoView : UIView

@property (nonatomic,strong) LHBWordModel *wordModel;

+ (instancetype)creatLHBVideoView;

@end
