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
//  如有问题或建议请联系我，我会马上回馈问题~ (ง •̀_•́)ง
//

#import <UIKit/UIKit.h>

@protocol ACActionSheetDelegate;


typedef void(^ACActionSheetBlock)(NSInteger buttonIndex);


@interface ACActionSheet : UIView



- (instancetype)initWithTitle:(NSString *)title delegate:(id<ACActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;


- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles actionSheetBlock:(ACActionSheetBlock) actionSheetBlock;


@property (nonatomic, copy) NSString *title;
@property (nonatomic, weak) id<ACActionSheetDelegate> delegate;


- (void)show;


@end




#pragma mark - ACActionSheet delegate

@protocol ACActionSheetDelegate <NSObject>

@optional

- (void)actionSheet:(ACActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex;

@end