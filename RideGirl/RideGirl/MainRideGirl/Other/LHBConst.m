/**
 *  主要放一些常量，全局通用
 *  .m主要放定义
 *  .h放 isiten 引用
 *
 *
 *
 */
#import "LHBConst.h"

CGFloat const LHBTitlesViewH = 35;
CGFloat const LHBTitlesViewY = 64;

/*精华cell图片帖子最大值，用来判断是否要显示大按钮*/
CGFloat const LHBWordPictureMaxH = 1000;
/*精华cell图片过长时显示默认长度，*/
CGFloat const LHBWordPictureNormalH = 250;

/**
 *  XMUser模型性别属性值
 */
/**
 *  XMUser模型性别属性值
 */
NSString * const  LHBUserSexMale = @"m";
NSString * const  LHBUserSexFemale = @"f";

/**
 *  tabar被选中的通知名字
 */
NSString * const  LHBTabBarDidSelectNotification = @"LHBTabBarDidSelectNotification";
/**
 *  tabar被选中的通知 - 被选中的控制器的索引 key
 */
NSString * const  LHBSeletecControllerIndexKey = @"LHBSeletecControllerIndexKey";
/**
 *  tabar被选中的通知 - 被选中的控制器 key
 */
NSString * const  LHBSeletecControllerKey = @"LHBSeletecControllerKey";
