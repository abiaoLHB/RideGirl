//
//  LHBWordModel.h
//  RideGirl
//
//  Created by LHB on 16/6/11.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHBWordModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *profile_image;
@property (nonatomic,copy) NSString *create_time;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,assign) NSInteger ding;
@property (nonatomic,assign) NSInteger cai;
@property (nonatomic,assign) NSInteger repost;
@property (nonatomic,assign) NSInteger comment;
@property (nonatomic,assign,getter=isSina_v) BOOL sina_v;
@end
