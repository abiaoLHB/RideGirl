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
/**
 *  所有的标签按钮
 */
@property (nonatomic,strong) NSMutableArray *tagsBtnArr;

@end

@implementation LHBAddTagsViewController

- (NSMutableArray *)tagsBtnArr
{
    if (!_tagsBtnArr) {
        _tagsBtnArr = [NSMutableArray array];
    }
    return _tagsBtnArr;
}


- (UIButton *)addBtn
{
    if (!_addBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, LHBMARGIN, 0, LHBMARGIN);
        btn.width = self.bigTagsView.width;
        btn.backgroundColor = LHBTagsBtnColor;
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
    //更新标签和文本框的frame
    [self updateTagBtnFrame];
}
/**
 *  添加标签按钮事件
 */
- (void)addBtnClick
{
    //添加一个标签按钮
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [tagButton setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    [tagButton setBackgroundColor:LHBTagsBtnColor];
    [tagButton addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton sizeToFit];
    [self.bigTagsView addSubview:tagButton];
    [self.tagsBtnArr addObject:tagButton];
    
    //清空textField文字
    self.textField.text = nil;
    //隐藏添加按钮
    self.addBtn.hidden = YES;
    //排序位置
    [self updateTagBtnFrame];
}

/**
 *  每次添加完按钮，就更新下布局
 */
- (void)updateTagBtnFrame
{
    //更新标签按钮的frame
    for (NSInteger i=0; i<self.tagsBtnArr.count; i++) {
        UIButton *tagBtn = self.tagsBtnArr[i];
        
        if (i==0) {//最前面的按钮,第一个按钮
            tagBtn.x = 0;
            tagBtn.y = 0;
        }else{//其他按钮，后面的按钮
            UIButton *lastTagBtn = self.tagsBtnArr[i-1];
            //计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagBtn.frame) + LHBTAGBTNMARGIN;
            //计算当前行右边的宽度
            CGFloat rightWidth = self.bigTagsView.width - leftWidth;
            if (rightWidth >= tagBtn.width) {//按钮在当前行显示
                tagBtn.y = lastTagBtn.y;
                tagBtn.x = leftWidth;
            }else{//换行显示
                tagBtn.x = 0;
                tagBtn.y = CGRectGetMaxY(lastTagBtn.frame)+LHBTAGBTNMARGIN;
            }
        }
    }
    
    UIButton *lastTagBtn = [self.tagsBtnArr lastObject];
    //更新textField的frame
    if (self.bigTagsView.width - CGRectGetMaxX(lastTagBtn.frame) - LHBTAGBTNMARGIN >= [self textFieldTextWidth]) {
        self.textField.x = CGRectGetMaxX(lastTagBtn.frame) + LHBTAGBTNMARGIN;
        self.textField.y = lastTagBtn.y;
    }else{
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY([[self.tagsBtnArr lastObject]frame]) + LHBTAGBTNMARGIN;
    }
}
/**
 *   标签按钮本身的点击
 */
- (void)tagBtnClick:(UIButton *)tagBtn
{
    [tagBtn removeFromSuperview];
    [self.tagsBtnArr removeObject:tagBtn];
    
    //重新更新所有标签的frame
    [UIView animateWithDuration:0.3 animations:^{
        [self updateTagBtnFrame];
    }];
}
/**
 *  textField的文字宽度
 */
- (CGFloat)textFieldTextWidth
{
    CGFloat textWidth = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(100, textWidth);
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
