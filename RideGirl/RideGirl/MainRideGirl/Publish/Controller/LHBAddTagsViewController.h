//
//  LHBAddTagsViewController.h
//  RideGirl
//
//  Created by LHB on 16/7/9.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHBAddTagsViewController : UIViewController

@property (nonatomic,copy) void (^tagsBtnTitleBlck)(NSArray *tagBtnTitleArr);
/**
 *  前一个控制器传过来的标签数组。用来在这个控制器一进来就显示的
 */
@property (nonatomic,strong) NSArray *tagsArr;
@end
