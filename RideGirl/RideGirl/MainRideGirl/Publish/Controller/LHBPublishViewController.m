//
//  LHBPublishViewController.m
//  RideGirl
//
//  Created by LHB on 16/6/25.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBPublishViewController.h"
#import "LHBPostWordViewController.h"
#import "LHBUINavigationController.h"
#import "LHBAutoLoginBtn.h"
#import <pop/POP.h>


static CGFloat const LHBAnimationDelay = 0.05;

@interface LHBPublishViewController ()

@property (nonatomic,strong) UIImageView *sloganImageView;

//属性block的写法
@property (nonatomic,copy) void  (^completionBlock)();

@end

@implementation LHBPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //一进来这个页面，让整个页面不能被点击，防止按钮在下落过程中被点击，细节问题
    self.view.userInteractionEnabled = NO;
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    // 中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (LHBScreenH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (LHBScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i<images.count; i++) {
        LHBAutoLoginBtn *button = [[LHBAutoLoginBtn alloc] init];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        // 计算frame
//        button.width = buttonW;
//        button.height = buttonH;
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        //最终的一个位置
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        // 开始时的位置在上面，看不到
        CGFloat buttonBeginY = buttonEndY - LHBScreenH;
        [self.view addSubview:button];
        
        //给每一个按钮添加动画
        //在view上改frame
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        //要单独改y值，在lay上改
        //POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = 10;
        anim.springSpeed = 10;
        anim.beginTime = CACurrentMediaTime() + LHBAnimationDelay  * i;
        //当最后一个动画执行完毕后，恢复整个页面的点击事件
        [anim setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
            self.view.userInteractionEnabled = YES;
        }];
        [button pop_addAnimation:anim forKey:nil];
    }
    
    //添加标题
    UIImageView *sloganImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
//    sloganImageView.y = LHBScreenH * 0.2;
//    //从xib中创建出来的view，xib中多大，加载出来就是多大！！！不建议用view.frame来取出尺寸
//    sloganImageView.centerX = LHBScreenW * 0.5;
    [self.view addSubview:sloganImageView];
    self.sloganImageView = sloganImageView;
    
    //标题动画
    POPSpringAnimation *anmi = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = LHBScreenW * 0.5;
    CGFloat centerEndY = LHBScreenH * 0.2;
    //随便，只要看不见就行
    CGFloat centerBeginY = centerEndY - LHBScreenH;
    anmi.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anmi.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anmi.beginTime = LHBAnimationDelay * images.count + 0.5;
    [sloganImageView pop_addAnimation:anmi forKey:nil];
    

}

- (IBAction)cancleBtnClick
{
    //只是让控件掉下去，别的事情不做，没有block
    [self cancelWithCompletionBlock:nil];
}

/**
 *  点击空白处也要退出
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancleBtnClick];
}


- (void)buttonClick:(UIButton *)btn
{
  [self cancelWithCompletionBlock:^{
      if (btn.tag == 0) {
          LHBLog(@"发视频");
      }else if (btn.tag == 1){
          LHBLog(@"发图片");
      }else if (btn.tag == 2){
          LHBPostWordViewController *postWordVC = [[LHBPostWordViewController alloc] init];
          //这里不能用self去 present。因为 self 已经dismiss了
          //[self presentViewController:postWordVC animated:YES completion:nil];
          
          UIViewController *tempVC = [[UIApplication sharedApplication] keyWindow].rootViewController;
          //包装一个导航控制器
          LHBUINavigationController *nav = [[LHBUINavigationController alloc] initWithRootViewController:postWordVC];
          [tempVC presentViewController:nav animated:YES completion:nil];
      }
  }];
}

//参数block属性的写法
- (void)cancelWithCompletionBlock:(void (^)())completionBlock
{
    self.view.userInteractionEnabled = NO;
    int beginIndex = 2;
    
    for (NSInteger i=0; i<self.view.subviews.count; i++) {
        UIView *subView = self.view.subviews[i];
        
        //基本动画，控制器都要死了，不要弹了
        POPBasicAnimation *anmi = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerEndY = subView.centerY + LHBScreenH;
        //起始位置会是当前默认位置
        //终点位置
        anmi.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerEndY)];
        anmi.beginTime = CACurrentMediaTime() + (i-beginIndex)*LHBAnimationDelay;
        //动画执行节奏(先慢后快 )
        //anmi.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [subView pop_addAnimation:anmi forKey:nil];
        
        if (i == self.view.subviews.count-1) {//最后一个动画
            [anmi setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                
                //执行传进来的completionBlock参数
                //一定要判断是不是空block，空的话直接报错
                if (completionBlock) {
                    completionBlock();
                }
                //装逼写法
                //!completionBlock ? : completionBlock();
            }];
        }
    }
    

}






//／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／
/**
 *  测试：可以通过延时来给每一按钮添加动画，以达到挨着落的效果
 */
- (void)afterTimer
{
    //
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i*0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //
    //            //给每一个按钮添加动画
    //            //在view上改frame
    //            POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    //            //要单独改y值，在lay上改
    //            //POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    //            anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
    //            anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
    //            anim.springBounciness = 10;
    //            anim.springSpeed = 10;
    //            [button pop_addAnimation:anim forKey:nil];
    //        });
}



/**
 *  pop动画介绍
 */
- (void)testPop

{
    //往view上添加动画
    //[self addPopAnimationToView];
    
    //往图层上添加动画
//    [self addPopAnimationToLayer];
    
}

//pop动画测试
/**
 pop和Core Animation的区别
 1.Core Animation的动画只能添加到layer上
 2.pop的动画能添加到任何对象
 3.pop的底层并非基于Core Animation, 是基于CADisplayLink
 4.Core Animation的动画仅仅是表象, 并不会真正修改对象的frame\size等值
 5.pop的动画实时修改对象的属性, 真正地修改了对象的属性
 */

//添加到view
- (void)addPopAnimationToView
{
//    POPSpringAnimation 弹簧动画
//    POPBasicAnimation  基本动画
//    POPDeacayAnimation 衰减动画
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
//    kPOPViewAlpha
//    anim.fromValue = @(1.0);
//    anim.toValue = @(0.0);
    
//    kPOPViewCenter
    anim.springSpeed = 20;
    anim.springBounciness  = 20;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    
    //key 可以通过这个key找到这个动画
    [self.sloganImageView pop_addAnimation:anim forKey:nil];
}


- (void)addPopAnimationToLayer
{
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    //2秒后开始执行(CACurrentMediaTime() 从当前时间)
    anim.beginTime = CACurrentMediaTime() + 2.0;
    anim.springSpeed = 20;
    anim.springBounciness  = 20;
    //当前图层的y
    anim.fromValue = @(self.sloganImageView.layer.position.y);
    anim.toValue = @(300);
    
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
        LHBLog(@"动画执行完毕");
    };
    
    [self.sloganImageView.layer pop_addAnimation:anim forKey:nil];
}

@end
