//
//  LHBWordModel.m
//  RideGirl
//
//  Created by LHB on 16/6/11.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBWordModel.h"
#import "NSDate+LHBDateExtension.h"
#import <MJExtension/MJExtension.h>

@implementation LHBWordModel
{
    CGFloat _cellH;
    CGRect  _imageFrame;
}
//<MJExtension/MJExtension.h> 自定义的属性代替真实的model属性
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2"
             };
}
//另一种方式
//+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
//{
//    if ([propertyName isEqualToString:@"small_image"]) {
//        return @"image0";
//    }
//    return propertyName;
//}



- (NSString *)create_time
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] daltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }
}

- (CGFloat)cellH
{
    if (!_cellH) {
        
        NSLog(@"%s",__func__);
        
        CGFloat textY = 55;
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-40, MAXFLOAT);
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil].size.height;
        //段子cell的高度，最基本的
        _cellH= textY + textH +64 ;
       
        //图片
        if (self.type == LHBWordTypePicture) {
            //图片等比例显示，因为图片的宽高可能大于或者小于屏款
            CGFloat imageW = maxSize.width;//和文字同宽
            CGFloat imageH = imageW * self.height / self.width;
            if (imageH >= LHBWordPictureMaxH) {
                imageH = LHBWordPictureNormalH;
                self.bigPicture = YES;
            }
            //计算图片的frame
            _imageFrame = CGRectMake(10, textY+textH+10, imageW, imageH);
            
            _cellH += imageH + 10;
        }else if (self.type == LHBWordTypeVoice){// 声音
            CGFloat voiceX = 10;
            CGFloat voiceY = textY+textH+10;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _cellH += voiceH + 10;
        }
    }
    return _cellH;
}
@end
