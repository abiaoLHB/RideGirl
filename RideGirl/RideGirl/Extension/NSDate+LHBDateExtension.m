//
//  NSDate+LHBDateExtension.m
//  RideGirl
//
//  Created by LHB on 16/6/13.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "NSDate+LHBDateExtension.h"

@implementation NSDate (LHBDateExtension)

- (NSDateComponents *)daltaFrom:(NSDate *)fromDate
{
    //创建日历，用来比较年月日差值
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return  [calendar components:unit fromDate:fromDate toDate:self options:0];
}
//一个元素一个元素的拿
/*
 NSInteger year = [calendar component:NSCalendarUnitYear fromDate:now];
 NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:now];
 */

@end
