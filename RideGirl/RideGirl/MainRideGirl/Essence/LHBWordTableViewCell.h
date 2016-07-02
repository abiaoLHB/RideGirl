//
//  LHBWordTableViewCell.h
//  RideGirl
//
//  Created by LHB on 16/6/12.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHBWordModel;

@interface LHBWordTableViewCell : UITableViewCell
//帖子模型
@property (nonatomic,strong) LHBWordModel *wordModel;

+ (instancetype)creatWordTabelViewCell;

@end
