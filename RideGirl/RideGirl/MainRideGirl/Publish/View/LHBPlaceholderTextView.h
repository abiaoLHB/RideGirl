//
//  LHBPlaceholderTextView.h
//  RideGirl
//
//  Created by LHB on 16/7/9.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHBPlaceholderTextView : UITextView
/**
 *  占位文字
 */
@property (nonatomic,copy) NSString *placeholder;
/**
 *  占位文字颜色
 */
@property (nonatomic,strong) UIColor *placeholderColor;


@end
