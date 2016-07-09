//
//  LHBPlaceholderTextView.m
//  RideGirl
//
//  Created by LHB on 16/7/9.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBPlaceholderTextView.h"

@implementation LHBPlaceholderTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //给font赋值，否则不给它赋个值的话，font凭空为空，drewRect的时候，字典里面为空崩溃
        //默认字体
        self.font = [UIFont systemFontOfSize:15];
        //默认字体颜色
        self.placeholderColor = [UIColor grayColor];
        
        //监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
/**
 *  文字改变通知方法,监听文字改变
 */
- (void)textDidChange
{
    //有文字，占位文字就隐藏，没有文字，占位文字就出来
    //文字一改变，就调用setNeedsDisplay，就会调用重绘方法drawRect，drawRect每次调用，都会先擦掉上一次绘制的东西,然后在画一遍
    //也就是文字一改变，就擦出占位位子，有文字，drawRect返回，不画。没有文字，就画。
    [self setNeedsDisplay];
}



/**
 *  要想把自定义的placeholder属性显示出来，有多种方案，
 *  第一种方案：把文字画上来:绘制占位文字
 */
- (void)drawRect:(CGRect)rect
{
    //如果有文字，不画了,就返回，不画占位文字了，也就没有占位文字了，只有输入的内容
    //当然，self.text不一定是纯文字，也有可能是富文本，富文本时，只判断self.text.length不严谨
    //if (self.text.length || self.attributedText.length) return;
    
    //引申出另一种写法
    if (self.hasText) return;
    
    rect.origin.x = 4;
    rect.origin.y = 7;
    rect.size.width -= 2 * rect.origin.x;
    
    NSMutableDictionary *attris = [NSMutableDictionary dictionary];
    attris[NSFontAttributeName] = self.font;
    attris[NSForegroundColorAttributeName] = self.placeholderColor;
    //注意⚠️：rect不对可能画不到正确的位置，导致看不见！
//    [self.placeholder drawInRect:CGRectMake(0, 0, self.width, self.height) withAttributes:attris];
    
    [self.placeholder drawInRect:rect withAttributes:attris];
}
/**
 *  占位文字的显示隐藏
 第一种方案：可以在控制器里，遵守UITextView的代理协议，实现textDidChang方法，来监听textView中占位文字的显示与否。但是这个方案不太好，因为textView占位文字的显示与否，而且所有用到这个控制器的低昂，都得要处理控制器的占位文字，所以最好交给textView自己内部来实现。
 第一种方案：通知。只要textView的文字发生改变，就会发出通知。UITextField一样也会翻出通知
 */


/**
 *  重写一堆的set方法，防止外界改了属性而没有反应
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self setNeedsDisplay];
}
/**
 *  placeholder字体是实用的textView的字体，如果外界textView的字体变了，placeholder字体也得重画
 *  这个是父类的属性，要调用super
 */
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}
/**
 *  通过代码改textView的文字，是不会发通知的
 */
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}
@end
