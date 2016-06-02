//
//  LHBRecommendRightCell.h
//  RideGirl
//
//  Created by LHB on 16/6/2.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHBRecommendRightModel;

@interface LHBRecommendRightCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbel;
@property (weak, nonatomic) IBOutlet UILabel *fanseLabel;

@property (nonatomic,strong) LHBRecommendRightModel *rightModel;

@end
