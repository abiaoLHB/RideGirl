//
//  LHBCommentHeaderView.h
//  RideGirl
//
//  Created by LHB on 16/7/2.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHBCommentHeaderView : UITableViewHeaderFooterView
/**
 *  把显示的文字传过来就行了
 */
@property (nonatomic,copy) NSString *title;

+ (instancetype)creatCommetHeaderView:(UITableView *)tableView;

@end
