//
//  LHBMeCell.m
//  RideGirl
//
//  Created by LHB on 16/7/6.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBMeCell.h"

@implementation LHBMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        
        self.textLabel.font = [UIFont systemFontOfSize:16];
        self.textLabel.textColor = [UIColor lightGrayColor];
    }
    return self;
}
/**
 *  默认分组间隔比较大的原因是每组都有一个默认的header＋header
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) {
        return;
    }
    self.imageView.width = 30;
    self.imageView.height = 30;
    self.imageView.centerY = self.contentView.height * 0.5;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + LHBMARGIN;
}
//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.y -= 25;
//    [super setFrame:frame];
//}
@end
