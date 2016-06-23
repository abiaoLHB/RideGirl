//
//  LHBProgressView.m
//  RideGirl
//
//  Created by LHB on 16/6/23.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBProgressView.h"

@implementation LHBProgressView

- (void)awakeFromNib
{
    self.roundedCorners = 2.0;
    self.progressLabel.textColor = [UIColor whiteColor];

}


- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%d%%",(int)(progress * 100)];
    //负进度
    text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    self.progressLabel.text = text;
}
@end
