//
//  LHBWordVoiceView.h
//  RideGirl
//
//  Created by LHB on 16/6/27.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHBWordModel;

@interface LHBWordVoiceView : UIView

@property (nonatomic,strong) LHBWordModel *wordModel;

+ (instancetype)creatLHBVoicePictureView;

@end
