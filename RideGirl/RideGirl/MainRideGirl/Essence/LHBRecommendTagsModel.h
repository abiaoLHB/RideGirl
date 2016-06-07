//
//  LHBRecommendTagsModel.h
//  RideGirl
//
//  Created by LHB on 16/6/7.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHBRecommendTagsModel : NSObject
/*
 "image_list" = "http://img.spriteapp.cn/ugc/2016/03/10/092924_69853.jpg";
 "is_default" = 0;
 "is_sub" = 0;
 "sub_number" = 148574;
 "theme_id" = 3096;
 "theme_name" = "\U767e\U601d\U7ea2\U4eba";
 */

@property (nonatomic,copy) NSString *image_list;
@property (nonatomic,copy) NSString *theme_name;
@property (nonatomic,assign) NSInteger sub_number;

@end
