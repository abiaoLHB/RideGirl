//
//  LHBCusTomTextField.m
//  RideGirl
//
//  Created by LHB on 16/6/10.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBCusTomTextField.h"
#import <objc/runtime.h>

static NSString * const LHBPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation LHBCusTomTextField
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
- (void)awakeFromNib
{
    //    可以改
    //    UILabel *plcaeholderLabel = [self valueForKeyPath:@"_placeholderLabel"];
    //    plcaeholderLabel.textColor = [UIColor blueColor];
    
    //    或者一句代码
    //    [self setValue:[UIColor yellowColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    //    设置光标颜色
    //    self.tintColor = [UIColor orangeColor];
    //    self.tintColor = self.textColor;//和文字颜色一致
    
    
    
    //在RiderGirl中的应用
    [self resignFirstResponder];
    self.tintColor = [UIColor yellowColor];
    
}
#pragma mark - 当输入框聚焦时，调用，更改颜色。重写第一响应方法
- (BOOL)becomeFirstResponder
{
    //成为第一响应，就修改placeholder的文字颜色
    [self setValue:self.textColor forKeyPath:LHBPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}

#pragma mark - 当焦点离开输入框时，调用，更改颜色。重写失去焦点方法
- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:LHBPlacerholderColorKeyPath];
    return [super resignFirstResponder];
}


+ (void)initialize
{
    //    [self getIvars];
}

+ (void)getProperties
{
    unsigned int count = 0;
    //相当于拷贝出来，要手动管理内存
    objc_property_t *propreties = class_copyPropertyList([UITextField class], &count);
    for (NSInteger i=0; i<count; i++) {
        //取出属性
        objc_property_t property = propreties[i];
        //打印属性名字
        NSLog(@"%s --- %s",property_getName(property),property_getAttributes(property));
    }
    //释放内存
    free(propreties);
    
}

+ (void)getIvars
{
    unsigned int count = 0;
    //相当于拷贝所有成员变量，要手动管理内存
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    for (NSInteger i=0; i<count; i++) {
        //取出成员变量
        //        Ivar ivar = *(ivars + i);
        Ivar ivar = ivars[i];
        
        //打印一下看看UITextField里面隐藏的成员变量的名字
        NSLog(@"%s --- %s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    }
    //释放内存
    free(ivars);
    
    //会打印出一堆成员变量的名字，拿到这个成员变量的名字，可以通过kvc来更改内部属性,现在可以拿到_placeholderLabel
    
}


#pragma mark - 该方法只能实现高亮时更改placeholder的颜色。焦点离开时暂时改不了
//- (void)setHighlighted:(BOOL)highlighted
//{
//    [self setValue:self.textColor forKeyPath:LHBPlacerholderColorKeyPath];
//}


#pragma mark - 想写个框架似的，可以在外部加一属性，重写set方法，方便外部更改

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setValue:placeholderColor forKeyPath:LHBPlacerholderColorKeyPath];
}

/**
 运行时(Runtime):
 * 苹果官方一套C语言库
 * 能做很多底层操作(比如访问隐藏的一些成员变量\成员方法....)
 */


@end
