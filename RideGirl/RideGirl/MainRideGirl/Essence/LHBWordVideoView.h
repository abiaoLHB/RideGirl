//
//  LHBWordVideoView.h
//  RideGirl
//
//  Created by LHB on 16/6/28.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHBVideoPlayBtn.h"

@class LHBWordModel;

@interface LHBWordVideoView : UIView

@property (nonatomic,strong) LHBWordModel *wordModel;
//播放按钮
@property (weak, nonatomic) IBOutlet LHBVideoPlayBtn *videoPlayButton;

+ (instancetype)creatLHBVideoView;

@end
