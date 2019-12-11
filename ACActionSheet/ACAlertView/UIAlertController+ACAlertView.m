//
//  UIAlertController+ACAlertView.m
//  ACActionSheetDemo
//
//  Created by zhangziyun

//  GitHub:     https://github.com/GardenerYun
//  Email:      gardeneryun@foxmail.com
//  简书博客地址: http://www.jianshu.com/users/8489e70e237d/latest_articles
//  如有问题或建议请联系我，我会马上解决问题~ (ง •̀_•́)ง

// Copyright (C) 2016 by 章子云
//
// Permission is hereby granted, free of charge, to any
// person obtaining a copy of this software and
// associated documentation files (the "Software"), to
// deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the
// Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall
// be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
// BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
// ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#import "UIAlertController+ACAlertView.h"

@implementation UIAlertController (ACAlertView)

#pragma mark - init/create methods
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title
                                 message:(nullable NSString *)message
                       cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                      confirmButtonTitle:(nullable NSString *)confirmButtonTitle
                          preferredStyle:(UIAlertControllerStyle)preferredStyle
                          alertViewBlock:(nullable ACAlertViewBlock)alertViewBlock {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message cancelButtonTitle:cancelButtonTitle confirmButtonTitle:confirmButtonTitle otherButtonTitles:nil preferredStyle:preferredStyle alertViewBlock:alertViewBlock];
    
    return alertController;
}


+ (instancetype)alertControllerWithTitle:(nullable NSString *)title
                                 message:(nullable NSString *)message
                       cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                      confirmButtonTitle:(nullable NSString *)confirmButtonTitle
                       otherButtonTitles:(nullable NSArray <NSString *>*)otherButtonTitles
                          preferredStyle:(UIAlertControllerStyle)preferredStyle
                          alertViewBlock:(nullable ACAlertViewBlock)alertViewBlock {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    NSMutableArray *titles = [NSMutableArray array];
    
    if (cancelButtonTitle.length > 0) {
        [titles addObject:cancelButtonTitle];
    }
    
    if (confirmButtonTitle.length > 0) {
        [titles addObject:confirmButtonTitle];
    }
    
    if (otherButtonTitles.count > 0) {
        [titles addObjectsFromArray:otherButtonTitles];
    }
    
    for (NSInteger i=0; i<titles.count; i++) {
        
        // alertAction默认风格为Default；第一个alertAction设置为StyleCancel
        UIAlertActionStyle style = UIAlertActionStyleDefault;
        if (i==0) {
            style = UIAlertActionStyleCancel;
        }
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:titles[i] style:style handler:^(UIAlertAction * _Nonnull action) {
                if (alertViewBlock) {
                    alertViewBlock(i);
                }
            }];
        
        [alertController addAction:alertAction];
    }
             
    return alertController;
}


#pragma mark - Public methods
- (void)show {
    [self showWithAnimated:YES completion:nil];
}


- (void)showWithAnimated:(BOOL)animated completion:(void (^__nullable)(void))completion {
    [[self _getCurrentViewController] presentViewController:self animated:animated completion:completion];
}


#pragma mark - Private methods
- (UIViewController *)_getCurrentViewController{

    UIViewController* currentViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;;
    while (YES) {
        
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                currentViewController = currentViewController.childViewControllers.lastObject;
                return currentViewController;
            } else {
                return currentViewController;
            }
        }
        
    }
}
@end
