//
//  LHBTagsBtn.m
//  RideGirl
//
//  Created by LHB on 16/7/10.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBTagsBtn.h"

@implementation LHBTagsBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        //和外部的textField字体一样
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        [self setBackgroundColor:LHBTagsBtnColor];

    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    //sizeToFit 要放在设置后面，防止设置完字体又被算回去
    //先算完
    [self sizeToFit];
    //算完以后给按钮加上三个间距，再在layoutSubviews里均匀的调整这三个间距，左中右。
    self.width += 3 * LHBTAGBTNMARGIN;
    //算完再算高度
    self.height = LHBTAGSFIELDHEIGHT;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = LHBTAGBTNMARGIN;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame)+LHBTAGBTNMARGIN;
    self.imageView.size = CGSizeMake(15, 15);//本来是18，该小了一点
    self.imageView.centerY = self.titleLabel.centerY;
}

@end
