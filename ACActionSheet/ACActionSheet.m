//
//  ACActionSheet.m
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

#import "ACActionSheet.h"



@interface ACActionSheet ()

@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, copy) NSString *destructiveButtonTitle;
@property (nonatomic, copy) NSArray *otherButtonTitles;

@property (nonatomic, strong) UIView *buttonBackgroundView;
@property (nonatomic, strong) UIView *darkShadowView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, copy) ACActionSheetBlock actionSheetBlock;

@end

@implementation ACActionSheet
#pragma mark - Life Cycle
- (instancetype)initWithTitle:(NSString *)title
                     delegate:(id<ACActionSheetDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {

    self = [super init];
    if(self) {
        _title = title;
        _delegate = delegate;
        _cancelButtonTitle = cancelButtonTitle.length>0 ? cancelButtonTitle : @"取消";
        _destructiveButtonTitle = destructiveButtonTitle;
        
        NSMutableArray *args = [NSMutableArray array];
        
        if(_destructiveButtonTitle.length) {
            [args addObject:_destructiveButtonTitle];
        }
        
        [args addObject:otherButtonTitles];
        
        if (otherButtonTitles) {
            va_list params;
            va_start(params, otherButtonTitles);
            id buttonTitle;
            while ((buttonTitle = va_arg(params, id))) {
                if (buttonTitle) {
                    [args addObject:buttonTitle];
                }
            }
            va_end(params);
        }
        
        _otherButtonTitles = [NSArray arrayWithArray:args];
     
        [self _initSubViews];
    }
    
    return self;
}


- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
             actionSheetBlock:(ACActionSheetBlock)actionSheetBlock {
    
    self = [super init];
    if(self) {
        _title = title;
        _cancelButtonTitle = cancelButtonTitle.length>0 ? cancelButtonTitle : @"取消";
        _destructiveButtonTitle = destructiveButtonTitle;
        
        NSMutableArray *titleArray = [NSMutableArray array];
        if (_destructiveButtonTitle.length) {
            [titleArray addObject:_destructiveButtonTitle];
        }
        [titleArray addObjectsFromArray:otherButtonTitles];
        _otherButtonTitles = [NSArray arrayWithArray:titleArray];
        self.actionSheetBlock = actionSheetBlock;
        
        [self _initSubViews];
    }
    
    return self;
    
}

#pragma mark - init/Create Methods
- (void)_initSubViews {

    self.frame = CGRectMake(0, 0, ACScreenWidth, ACScreenHeight);
    self.backgroundColor = [UIColor clearColor];
    self.hidden = YES;
    
    /// 透明灰色蒙版
    _darkShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ACScreenWidth, ACScreenHeight)];
    _darkShadowView.backgroundColor = ACRGB(20, 20, 20);
    _darkShadowView.alpha = 0.0f;
    [self addSubview:_darkShadowView];
    /// 透明灰色蒙版 添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_dismissViewAction:)];
    [_darkShadowView addGestureRecognizer:tap];
    
    /// 所有按钮父视图
    _buttonBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    _buttonBackgroundView.backgroundColor = ACRGB(240, 240, 240);
    [self addSubview:_buttonBackgroundView];
    _buttonBackgroundView.layer.cornerRadius = ACViewCornerRadius;
    _buttonBackgroundView.clipsToBounds = YES;
    

    [self _initNormalButtons];
    
}



/// 初始化常规类型actionSheet
- (void)_initNormalButtons {
    /// 创建标题
    CGFloat titleLabelHeight = 0;
    if (self.title.length) {
        titleLabelHeight = ACTitleHeight;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                        0,
                                                                        ACScreenWidth,
                                                                        titleLabelHeight)];
        titleLabel.text = _title;
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = ACRGB(125, 125, 125);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:14.0f];
        titleLabel.backgroundColor = [UIColor whiteColor];
        [_buttonBackgroundView addSubview:titleLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = ACRGB(230, 230, 230);
        line.frame = CGRectMake(0, titleLabelHeight-1, ACScreenWidth, 0.5);
        [_buttonBackgroundView addSubview:line];
    }
    
    /// 使用ScrollView展示button
    /// 计算button个数，大于限制则表格可滑动. 小于等于限制个数则直接展示不可滑动
    [self.buttonBackgroundView addSubview:self.scrollView];
    NSInteger maxCount = ACScreenHeight/ACButtonHeight * 0.7;
    NSInteger showListCount = _otherButtonTitles.count;
    
    if (showListCount > maxCount) {
        showListCount = maxCount;
        self.scrollView.scrollEnabled = YES;
        self.scrollView.showsVerticalScrollIndicator = YES;
    } else {
        self.scrollView.scrollEnabled = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
    }

    self.scrollView.frame = CGRectMake(0, titleLabelHeight, ACScreenWidth, showListCount*ACButtonHeight);
    [self.scrollView setContentSize:CGSizeMake(ACScreenWidth, _otherButtonTitles.count*ACButtonHeight)];
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {

    }
    
    /// 创建Button
    for (int i = 0; i < _otherButtonTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button setTitle:_otherButtonTitles[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        button.titleLabel.font = ACButtonTitleFont;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        /// 如果有红色警示按钮
        if (i==0 && _destructiveButtonTitle.length) {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        UIImage *image = [UIImage imageWithContentsOfFile:[[self _acBundle] pathForResource:@"actionSheetHighLighted@2x" ofType:@"png"]];
        [button setBackgroundImage:image forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(_didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonY = ACButtonHeight * i;
        button.frame = CGRectMake(0, buttonY, ACScreenWidth, ACButtonHeight);
        [self.scrollView addSubview:button];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = ACRGB(230, 230, 230);
        line.frame = CGRectMake(0, buttonY, ACScreenWidth, 0.5);
        /// 第一个不添加分割线
        if (i!=0) {
            [self.scrollView addSubview:line];
        }
    }
    
    /// 分割View
    CGFloat separatorViewY = titleLabelHeight + ACButtonHeight * showListCount;
    
    UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, separatorViewY, ACScreenWidth, ACSeparatorViewHeight)];
    separatorView.backgroundColor = ACRGB(240, 240, 240);
    [_buttonBackgroundView addSubview:separatorView];

    /// 创建取消Button
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, separatorViewY+ACSeparatorViewHeight, ACScreenWidth, ACButtonHeight+ACSafeAreaHeight);
    
    cancelButton.tag = _otherButtonTitles.count;
    [cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor whiteColor];
    cancelButton.titleLabel.font = ACButtonTitleFont;
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIImage *image = [UIImage imageWithContentsOfFile:[[self _acBundle] pathForResource:@"actionSheetHighLighted@2x" ofType:@"png"]];
    [cancelButton setBackgroundImage:image forState:UIControlStateHighlighted];
    
    [cancelButton addTarget:self action:@selector(_didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonBackgroundView addSubview:cancelButton];
    
    [cancelButton setTitleEdgeInsets:UIEdgeInsetsMake(-ACSafeAreaHeight, 0, 0, 0)];
    
    /// 最后计算 所有按钮父视图的frame
    CGFloat height = titleLabelHeight + ACButtonHeight * showListCount + ACSeparatorViewHeight + cancelButton.frame.size.height;
    _buttonBackgroundView.frame = CGRectMake(0, ACScreenHeight, ACScreenWidth, height);
}


#pragma mark - Public Methods

- (void)show {

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    self.hidden = NO;

    ACWeakSelf;
    [UIView animateWithDuration:ACShowAnimateDuration
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:10
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
        weakSelf.darkShadowView.alpha = ACDarkShadowViewAlpha;
        weakSelf.buttonBackgroundView.transform = CGAffineTransformMakeTranslation(0, -weakSelf.buttonBackgroundView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark - Private methods
/// 点击按钮
- (void)_didClickButton:(UIButton *)button {

    if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:didClickedButtonAtIndex:)]) {
        [_delegate actionSheet:self didClickedButtonAtIndex:button.tag];
    }
    
    if (self.actionSheetBlock) {
        self.actionSheetBlock(button.tag);
    }
    
    [self _hide];
}

- (void)_dismissViewAction:(UITapGestureRecognizer *)tap {

    if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:didClickedButtonAtIndex:)]) {
        [_delegate actionSheet:self didClickedButtonAtIndex:_otherButtonTitles.count];
    }
    
    if (self.actionSheetBlock) {
        self.actionSheetBlock(_otherButtonTitles.count);
    }
    
    [self _hide];
}

- (void)_hide {
    
    ACWeakSelf;
    [UIView animateWithDuration:ACHideAnimateDuration animations:^{
        weakSelf.darkShadowView.alpha = 0;
        weakSelf.buttonBackgroundView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
        [weakSelf removeFromSuperview];
    }];
}


- (NSBundle *)_acBundle {
    
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[ACActionSheet class]] pathForResource:@"ACActionSheet" ofType:@"bundle"]];
    
    return bundle;
}

#pragma mark - Getters Setters
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = UIScrollView.alloc.init;
        _scrollView.alwaysBounceVertical = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = UIColor.whiteColor;
        
    }
    return _scrollView;
}
@end
