//
//  LHBCommentViewController.m
//  RideGirl
//
//  Created by LHB on 16/7/1.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBCommentViewController.h"

@interface LHBCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 *  底部间距，用来跟随键盘
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@end

@implementation LHBCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageNormalName:@"comment_nav_item_share_icon" andHeightLightImageName:nil target:nil andAction:nil];
    //注册键盘弹出、隐藏通知。尽量用UIKeyboardWillChangeFrameNotification方法，因为既包含弹出，也包含隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
}

/**
 *  键盘变化处理方法
 */
- (void)keyboardWillChangeFrame:(NSNotification *)noti
{
    //CGRectValue --> 对象转换成CGRectValue
    //键盘弹出、隐藏后的frame，即当前的frame(最后的frame)
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    //直接这样写是不对的，因为即使键盘隐藏了，键盘的高度还是那么高
    //self.bottomSpace.constant = frame.size.height;
    
    //正确的做法是用屏幕的高度减去键盘的y值
    self.bottomSpace.constant = LHBScreenH - frame.origin.y;
    
    //键盘弹出时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //改完约束，强制布局一下，执行动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //实时监听 不太好,调用太频繁
    //- (void)scrollViewDidScroll:(UIScrollView *)scrollView
    [self.view endEditing:YES];
}





- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
