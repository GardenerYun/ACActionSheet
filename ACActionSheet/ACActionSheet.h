//
//  ACActionSheet.h
//  ACActionSheetDemo
//
//  Created by Zhangziyun on 16/5/3.
//  Copyright © 2016年 章子云. All rights reserved.
//
//  GitHub:     https://github.com/GardenerYun
//  Email:      gardeneryun@foxmail.com
//  简书博客地址: http://www.jianshu.com/users/8489e70e237d/latest_articles
//  如有问题或建议请联系我，我会马上解决问题~ (ง •̀_•́)ง
//

#define ACScreenWidth   [UIScreen mainScreen].bounds.size.width
#define ACScreenHeight  [UIScreen mainScreen].bounds.size.height
#define ACRGB(r,g,b)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define ACButtonTitleFont     [UIFont systemFontOfSize:17.0f]

#define ACTitleHeight 66.0f
#define ACButtonHeight  55.0f
#define ACSeparatorViewHeight 7.0f
#define ACWeakSelf __weak typeof(self) weakSelf = self;

#define ACViewCornerRadius 10.0f

#define ACDarkShadowViewAlpha 0.35f

#define ACShowAnimateDuration 0.4f
#define ACHideAnimateDuration 0.2f

/// 竖屏底部安全区域
#define ACSafeAreaHeight \
({CGFloat bottom=0.0;\
if (@available(iOS 11.0, *)) {\
bottom = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;\
} else { \
bottom=0;\
}\
(bottom);\
})


#import <UIKit/UIKit.h>

@protocol ACActionSheetDelegate;

typedef void(^ACActionSheetBlock)(NSInteger buttonIndex);

@interface ACActionSheet : UIView

/**
 *  type delegate
 *
 *  @param title                  title            (可以为空)
 *  @param delegate               delegate
 *  @param cancelButtonTitle      "取消"按钮         (默认有)
 *  @param destructiveButtonTitle "警示性"(红字)按钮  (可以为空)
 *  @param otherButtonTitles      otherButtonTitles
 */
- (instancetype)initWithTitle:(NSString *)title
                     delegate:(id<ACActionSheetDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 *  type block
 *
 *  @param title                  title            (可以为空)
 *  @param cancelButtonTitle      "取消"按钮         (默认有)
 *  @param destructiveButtonTitle "警示性"(红字)按钮  (可以为空)
 *  @param otherButtonTitles      otherButtonTitles
 *  @param actionSheetBlock       actionSheetBlock
 */
- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
             actionSheetBlock:(ACActionSheetBlock)actionSheetBlock;


@property (nonatomic, copy) NSString *title;
@property (nonatomic, weak) id<ACActionSheetDelegate> delegate;

- (void)show;

@end


#pragma mark - ACActionSheet delegate

@protocol ACActionSheetDelegate <NSObject>

@optional

- (void)actionSheet:(ACActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex;

@end
