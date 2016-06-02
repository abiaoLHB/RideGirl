//
//  LHBRecommendRightModel.h
//  RideGirl
//
//  Created by LHB on 16/6/2.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHBRecommendRightModel : NSObject
//"fans_count" = 5246;
//gender = 2;
//header = "http://wimg.spriteapp.cn/profile/large/2015/09/30/560b557be210a_mini.jpg";
//introduction = "";
//"is_follow" = 0;
//"is_vip" = 0;
//"screen_name" = "\U5b59\U900a \U7b491227\U4eba";
//"tiezi_count" = 272;
//uid = 9017486;

@property (nonatomic,assign) NSInteger fans_count;
@property (nonatomic,assign) NSInteger tiezi_count;
@property (nonatomic,copy) NSString *screen_name;
@property (nonatomic,copy) NSString *header;


@end
