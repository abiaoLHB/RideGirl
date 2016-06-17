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