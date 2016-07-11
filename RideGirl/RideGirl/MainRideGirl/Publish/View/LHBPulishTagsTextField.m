//
//  LHBPulishTagsTextField.m
//  RideGirl
//
//  Created by LHB on 16/7/11.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBPulishTagsTextField.h"

@implementation LHBPulishTagsTextField

- (void)deleteBackward
{
    //block有值就调一下
    !self.deleteBlock ? : self.deleteBlock();
    
    [super deleteBackward];

    //上面两句的顺序很重要。先掉父类方法，再掉block在这会导致当删除掉最后一个字符时，就调用block，此时的block就把上一个标签按钮给删了，而想要的效果是，当文字没有了以后，在点击一下删除键，才调用block，这里颠倒一下block和父类方法的顺序就行了。
}


@end
