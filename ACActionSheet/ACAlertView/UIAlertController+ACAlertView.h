//
//  UIAlertController+ACAlertView.h
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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ACAlertViewBlock)(NSInteger buttonIndex);

@interface UIAlertController (ACAlertView)




+ (instancetype)alertControllerWithTitle:(nullable NSString *)title
                                 message:(nullable NSString *)message
                       cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                      confirmButtonTitle:(nullable NSString *)confirmButtonTitle
                          preferredStyle:(UIAlertControllerStyle)preferredStyle
                          alertViewBlock:(nullable ACAlertViewBlock)alertViewBlock;



+ (instancetype)alertControllerWithTitle:(nullable NSString *)title
                                 message:(nullable NSString *)message
                       cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                      confirmButtonTitle:(nullable NSString *)confirmButtonTitle
                       otherButtonTitles:(nullable NSArray <NSString *>*)otherButtonTitles
                          preferredStyle:(UIAlertControllerStyle)preferredStyle
                          alertViewBlock:(nullable ACAlertViewBlock)alertViewBlock;



- (void)show;

- (void)showWithAnimated:(BOOL)animated completion:(void (^ __nullable)(void))completion;


@end

NS_ASSUME_NONNULL_END
