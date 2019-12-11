

# [ACActionSheet][1] - 一个简洁好用的ActionSheet/AlertView

[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/GardenerYun/ACActionSheet/master/LICENSE)
![podversion](https://img.shields.io/cocoapods/v/ACActionSheet.svg)

### **系统UIActionSheet其实挺好用的。但是有时候系统的风格跟APP有些不搭。而且在iOS8.0 UIKit更新了UIAlertController，苹果建议：*UIActionSheet is deprecated. Use UIAlertController with a preferredStyle of UIAlertControllerStyleActionSheet instead*。**

### [ACActionSheet][1]是仿微信效果的，简洁清新，方便好用

>  GitHub:     https://github.com/GardenerYun

> Email:      gardeneryun@foxmail.com

> 简书博客地址: http://www.jianshu.com/users/8489e70e237d/latest_articles

>  如有问题或建议请联系我，我会马上解决问题~ (ง •̀_•́)ง**




#### 2019年12月11日 更新 （v1.0.5）

1.优化逻辑，并支持CocoaPods： ```pod 'ACActionSheet'```

2.新增类目```UIAlertController+ACAlertView``` 
  为UIAlertController以UIAlertView（Deprecate）代码风格新增block初始化方法，详情见代码：

```
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
```



#### (v1.0.0)

- **这是微信效果截图**

![ACAcitonSheet_03](http://upload-images.jianshu.io/upload_images/1683760-a1efb2b8b5a0d07f.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240) ![ACAcitonSheet_01](http://upload-images.jianshu.io/upload_images/1683760-0313142e01c4178e.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240) ![ACAcitonSheet_02](http://upload-images.jianshu.io/upload_images/1683760-38bd04509523d024.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


----------


- **系统UIActionSheet （UIAlertController）gif 效果图**

![系统ActionSheet.gif](http://ww1.sinaimg.cn/large/a0a8dcc1gw1f3oyd5kd9kg208w0fsqcd.gif)  

----------

- **ACActionSheet gif 效果图**

![ACActionSheet.gif](http://ww4.sinaimg.cn/large/a0a8dcc1gw1f3oydmolofg208w0fs7aj.gif)

----------

## 代码示例
   **[ACActionSheet][1]尽力按照苹果UIKit代码风格编写。initWith...创建 -> show方法 -> delegate或block监听事件**
   
- **delegate模式 创建**

```
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
            
/***********************************************************************************/

ACActionSheet *actionSheet = [[ACActionSheet alloc] initWithTitle:@"保存或删除数据" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:@"保存",@"更改", nil];

[actionSheet show];

#pragma mark - ACActionSheet delegate
- (void)actionSheet:(ACActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"ACActionSheet delegate - %ld",buttonIndex);
}
```

- **block模式 创建**

```
typedef void(^ACActionSheetBlock)(NSInteger buttonIndex);

/**
 *  type block
 *
 *  @param title                  title            (可以为空)
 *  @param delegate               delegate
 *  @param cancelButtonTitle      "取消"按钮         (默认有)
 *  @param destructiveButtonTitle "警示性"(红字)按钮  (可以为空)
 *  @param otherButtonTitles      otherButtonTitles
 */
- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
             actionSheetBlock:(ACActionSheetBlock) actionSheetBlock;
             
             
/***********************************************************************************/
ACActionSheet *actionSheet = [[ACActionSheet alloc] initWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"小视频",@"拍照",@"从手机相册选择"] actionSheetBlock:^(NSInteger buttonIndex) {
        NSLog(@"ACActionSheet block - %ld",buttonIndex);
    }];
[actionSheet show];
```


  [1]: https://github.com/GardenerYun/ACActionSheet
 
