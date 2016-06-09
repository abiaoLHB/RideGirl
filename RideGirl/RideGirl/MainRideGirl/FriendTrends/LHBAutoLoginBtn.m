//
//  LHBAutoLoginBtn.m
//  RideGirl
//
//  Created by LHB on 16/6/9.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBAutoLoginBtn.h"

@implementation LHBAutoLoginBtn
//不管通过代码或者xib创建，都可以使用这个自定义按钮
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)awakeFromNib
{
    [self setup];
}
- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height-self.imageView.height;
}

@end
