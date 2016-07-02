//
//  LHBComment.h
//  RideGirl
//
//  Created by LHB on 16/6/30.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LHBUser;

@interface LHBComment : NSObject
/**
 *   评论的id
 */
@property (nonatomic,copy) NSString *ID;
/**
 *  音频文件的时长
 */
@property (nonatomic,assign) NSInteger voicetime;
/**
 *  音频文件的路径
 */
@property (nonatomic,copy) NSString *voiceurl;
/**
 *  评论的文字内容
 */
@property (nonatomic,copy) NSString *content;
/**
 *  被点赞的数量
 */
@property (nonatomic,assign) NSInteger like_count;
/**
 *  用户模型
 */
@property (nonatomic,strong) LHBUser *user;

@end
