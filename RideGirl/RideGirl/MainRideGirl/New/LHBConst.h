/**
 *  主要放一些常量，全局通用
 *  .m主要放定义
 *  .h放 UIKIT_EXTERN 引用
 *
 *
 *
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum {
    LHBWordTypeAll = 1,
    LHBWordTypePicture = 10,
    LHBWordTypeWord = 29,
    LHBWordTypeVoice = 31,
    LHBWordTypeVideo = 41
} LHBWordType;

UIKIT_EXTERN CGFloat const LHBTitlesViewH;
UIKIT_EXTERN CGFloat const LHBTitlesViewY;

UIKIT_EXTERN CGFloat const LHBWordPictureMaxH;
UIKIT_EXTERN CGFloat const LHBWordPictureNormalH;
/**
 *  XMUser模型性别属性值
 */
UIKIT_EXTERN NSString * const  LHBUserSexMale;
UIKIT_EXTERN NSString * const  LHBUserSexFemale;
/**
 *  tabar被选中的通知名字
 */
UIKIT_EXTERN NSString * const  LHBTabBarDidSelectNotification;
/**
 *  tabar被选中的通知 - 被选中的控制器的索引 key
 */
UIKIT_EXTERN NSString * const  LHBSeletecControllerIndexKey;
/**
 *  tabar被选中的通知 - 被选中的控制器 key
 */
UIKIT_EXTERN NSString * const  LHBSeletecControllerKey;

