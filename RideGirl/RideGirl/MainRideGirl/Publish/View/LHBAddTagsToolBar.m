//
//  LHBAddTagsToolBar.m
//  RideGirl
//
//  Created by LHB on 16/7/9.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBAddTagsToolBar.h"
#import "LHBAddTagsViewController.h"

@interface LHBAddTagsToolBar ()

@property (weak, nonatomic) IBOutlet UIView *topView;
/**
 *  存放所有的标签label
 */
@property (nonatomic,strong) NSMutableArray *tagLabelArr;
/**
 *  添加按钮
 */
@property (nonatomic,weak) UIButton *addBtn;


@end

@implementation LHBAddTagsToolBar

- (void)awakeFromNib
{
    //添加一个加号按钮，只创建一次就行了
    UIButton *addButton = [[UIButton alloc] init];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    //尺寸
    //1、
    //addButton.size = [UIImage imageNamed:@"tag_add_icon"].size;
    //2、
    //addButton.size = [addButton imageForState:UIControlStateNormal].size;
    //3、
    addButton.size = addButton.currentImage.size;
    addButton.x = LHBMARGIN;
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:addButton];
    self.addBtn = addButton;
}

- (void)addButtonClick
{
    LHBAddTagsViewController *addTagsVC = [[LHBAddTagsViewController alloc] init];
    
    //这一次这样拿这个控制器不对，因为selectedViewController的后面还model出来一个控制器，这个加号按钮是在model出来的这个控制器上面，而不是selectedViewController控制器
    //UITabBarController *tabBarVC = (UITabBarController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    //UINavigationController *nav = (UINavigationController *)tabBarVC.selectedViewController;
    
    //正确做法✅:谁把它model出来的，先找到谁，很显然是根控制器
    UIViewController *rootVC = [[UIApplication sharedApplication] keyWindow].
    rootViewController;
    
    
    //拿到传过来的tagsBtn的title
//    addTagsVC.tagsBtnTitleBlck = ^(NSArray *backArr){
//    //点出来的block得手写，最好用set方法，不用手写
//    };
    
    //自己写的block，最好弱引用一下，防止循环引用
    __weak typeof(self) weakSelf = self;
    [addTagsVC setTagsBtnTitleBlck:^(NSArray *tagsBtnTitleArr) {
        [weakSelf creatToolBarTags:tagsBtnTitleArr];
    }];
    //往后再传值
    addTagsVC.tagsArr = [self.tagLabelArr valueForKeyPath:@"text"];
    //一旦一个控制器model出来另一个控制器，就会通过presentedViewController属性引用着它.也可以通过属性回去。
    //rootVC.presentedViewController.presentingViewController 等于 rootVC
//    [a presentViewController:b animated:YES completion:nil];
//    a model 出来 b 控制器
//    a.presentedViewController  ----> b
//    b.presentingViewController ----> a
    
    UINavigationController *nav = (UINavigationController *)rootVC.presentedViewController;
    [nav pushViewController:addTagsVC animated:YES];
}

- (NSMutableArray *)tagLabelArr
{
    if (!_tagLabelArr) {
        _tagLabelArr = [NSMutableArray array];
    }
    return _tagLabelArr;
}


/**
 *  创建toolBar上面的标签
 */
- (void)creatToolBarTags:(NSArray *)tags
{
    //删除已添加的label
    [self.tagLabelArr makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //清空数组，防止数组越来越大
    [self.tagLabelArr removeAllObjects];
    
    for (NSInteger i=0;i<tags.count;i++) {
        
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.tagLabelArr addObject:tagLabel];
        tagLabel.backgroundColor = LHBTagsBtnColor;
        tagLabel.text = tags[i];
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.layer.cornerRadius = 5;
        tagLabel.clipsToBounds = YES;
        tagLabel.font = [UIFont systemFontOfSize:14];
        //先用设置的字体计算
        [tagLabel sizeToFit];
        tagLabel.width += LHBTAGBTNMARGIN;
        tagLabel.height = LHBTAGSFIELDHEIGHT;
        tagLabel.textColor = [UIColor whiteColor];
        [self.topView addSubview:tagLabel];
        
        //设置位置
        if (i==0) {//最前面的标签,第一个标签
            tagLabel.x = 0;
            tagLabel.y = 0;
        }else{//其他按钮，后面的按钮
            UILabel *lastTagLabel = self.tagLabelArr[i-1];
            //计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + LHBTAGBTNMARGIN;
            //计算当前行右边的宽度
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth >= tagLabel.width) {//按钮在当前行显示
                tagLabel.y = lastTagLabel.y;
                tagLabel.x = leftWidth;
            }else{//换行显示
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame)+LHBTAGBTNMARGIN;
            }
        }
        
    }
    
    UILabel *lastTagLabel = [self.tagLabelArr lastObject];
    //更新textField的frame
    if (self.topView.width - CGRectGetMaxX(lastTagLabel.frame) - LHBTAGBTNMARGIN >= self.addBtn.width) {
        self.addBtn.x = CGRectGetMaxX(lastTagLabel.frame) + LHBTAGBTNMARGIN;
        self.addBtn.y = lastTagLabel.y;
    }else{
        self.addBtn.x = 0;
        self.addBtn.y = CGRectGetMaxY([[self.tagLabelArr lastObject]frame]) + LHBTAGBTNMARGIN;
    }
}




















@end
