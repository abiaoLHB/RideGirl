//
//  LHBWordModel.h
//  RideGirl
//
//  Created by LHB on 16/6/11.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <Foundation/Foundation.h>//Foundation框架不识别flot属性
#import <UIKit/UIKit.h>

@interface LHBWordModel : NSObject
//帖子id
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *profile_image;
@property (nonatomic,copy) NSString *create_time;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,assign) NSInteger ding;
@property (nonatomic,assign) NSInteger cai;
@property (nonatomic,assign) NSInteger repost;
@property (nonatomic,assign) NSInteger comment;
@property (nonatomic,assign,getter=isSina_v) BOOL sina_v;
//图片的宽高
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
//图片规格地址
@property (nonatomic,copy) NSString *small_image;
@property (nonatomic,copy) NSString *large_image;
@property (nonatomic,copy) NSString *middle_image;
//帖子的类型
@property (nonatomic,assign) LHBWordType type;
//音频时长 s
@property (nonatomic,assign) NSInteger voicetime;
//音频播放次数
@property (nonatomic,assign) NSInteger playcount;
//视频播放时长
@property (nonatomic,assign) NSInteger videotime;
//最热评论
@property (nonatomic,strong) NSArray *top_cmt;

//视频播放地址
@property(nonatomic,copy)NSString *videouri;

//音频播放地址
@property(nonatomic,copy)NSString *weixin_url;


/*额外的属性*/
/*cell高度*/
@property (nonatomic,assign,readonly) CGFloat cellH;//readonly会报错，只会帮你生成get方法的实现，readonly没有set方法。因为你自己实现了get或者set方法，编译器就不会在生成成员变量了，成员变量也得你自己搞了(更正：当重写set方法时，才自己搞成员变量) ，自己写一个 {cellH},这样在写readonly（防止被人修改你cell的高度）就不报错了。写.h、.m、或者类扩展（既可以成员变量，又可以属性）都行
//图片控件的frame
@property (nonatomic,assign,readonly) CGRect imageFrame;

//声音控件的frame
@property (nonatomic,assign,readonly) CGRect voiceFrame;
//视频控件的frame
@property (nonatomic,assign,readonly) CGRect videoFrame;

//辅助属性，是否已经处理过图片长度
@property (nonatomic,assign,getter=isBigPicture) BOOL bigPicture;

//图片的下载进度
@property (nonatomic,assign) CGFloat imageViewProgress;

@end
