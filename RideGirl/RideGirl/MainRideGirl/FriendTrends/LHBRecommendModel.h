//
//  LHBRecommendModel.h
//  RideGirl
//
//  Created by LHB on 16/6/1.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHBRecommendModel : NSObject
/** id */
@property (nonatomic, assign) NSInteger id;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;

@property (nonatomic,strong) NSMutableArray *leftModelDataArr;
//总页数
@property (nonatomic,assign) NSInteger total_page;
//总数
@property (nonatomic,assign) NSInteger total;
//下一页
@property (nonatomic,assign) NSInteger next_page;




@end
