//
//  LHBAddTagsViewController.m
//  RideGirl
//
//  Created by LHB on 16/7/9.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBAddTagsViewController.h"

@interface LHBAddTagsViewController ()<UITextFieldDelegate>
/**
 *  容纳标签的view
 */
@property (nonatomic,weak) UIView *bigTagsView;
/**
 *  编辑标签的textField
 */
@property (nonatomic,weak) UITextField *textField;
/**
 *  编辑好标签后，添加按钮
 */
@property (nonatomic,strong) UIButton *addBtn;

@end

@implementation LHBAddTagsViewController

- (UIButton *)addBtn
{
    if (!_addBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, LHBMARGIN, 0, LHBMARGIN);
        btn.width = self.bigTagsView.width;
        btn.backgroundColor = LHBRGBColor(74, 139, 209);
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.height = 35;
        [self.bigTagsView addSubview:btn];
        _addBtn = btn;
    }
    return _addBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupBigTagsView];
    [self setupTagsTextField];
}
- (void)setupNav
{
    self.view.backgroundColor = LHBGlobalColor;
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateNormal];
}
/**
 *  当作标签的容器view
 */
- (void)setupBigTagsView
{
    UIView *bigTagsVeiw = [[UIView alloc] init];
    bigTagsVeiw.x = LHBMARGIN;
    bigTagsVeiw.y = LHBNAVHEIGHT + LHBMARGIN;
    bigTagsVeiw.width = LHBScreenW - 2 * LHBMARGIN;
    bigTagsVeiw.height = LHBScreenH;
    [self.view addSubview:bigTagsVeiw];
    self.bigTagsView = bigTagsVeiw;
}

/**
 *  编辑标签的TextField
 */
- (void)setupTagsTextField
{
    UITextField *textField = [[UITextField alloc] init];
    textField.width = self.bigTagsView.width;
    textField.height = 25;
    textField.delegate = self;
    textField.placeholder = @"多个标签请用逗号或者回车隔开";
    [textField becomeFirstResponder];
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.bigTagsView addSubview:textField];
    self.textField = textField;
}
//监听textField文字改变
- (void)textDidChange
{
    if (self.textField.hasText) {
        self.addBtn.hidden = NO;
        self.addBtn.y = CGRectGetMaxY(self.textField.frame) + LHBMARGIN;
        [self.addBtn setTitle:self.textField.text forState:UIControlStateNormal];
        
    }else{
        self.addBtn.hidden = YES;
    
    }
}
/**
 *  添加标签按钮事件
 */
- (void)addBtnClick
{
    
}


- (void)done
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate
/**
 *  textView 有textViewDidChange代理方法，而textField没有这个方法
 */
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    //return YES ，打出的文字可以输入文本框，return NO 不能输入到文本框。这个方法，当每点击一下键盘的按键，就会调用。但是在中文输入法下，点击待选的文字，是不触发这个代理方法，所以用这个代理方法监听文字的改变，不可靠。所以监听textField文字的变化，不建议使用代理方法。可以用通知，因为UITextField继承自UIControl，可以通过addTarget添加方法
//    LHBLogFunc;
//    return YES;
//}
















@end
