//
//  LHBPulishTagsTextField.h
//  RideGirl
//
//  Created by LHB on 16/7/11.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHBPulishTagsTextField : UITextField
/**
 *  按了删除按钮后的回调
 */
@property (nonatomic,copy) void (^deleteBlock)();
@end
