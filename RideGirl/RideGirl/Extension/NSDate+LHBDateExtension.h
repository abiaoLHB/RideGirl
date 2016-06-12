//
//  NSDate+LHBDateExtension.h
//  RideGirl
//
//  Created by LHB on 16/6/13.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LHBDateExtension)
/**
 *  比较fromDate 的时间和self的时间差值
 */
- (NSDateComponents *)daltaFrom:(NSDate *)fromDate;

@end
