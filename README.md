# [ACActionSheet][1] - 仿微信ActionSheet

> **系统UIActionSheet其实挺好用的。但是有时候系统的风格跟APP有些不搭。
而且在iOS8.0 UIKit更新了UIAlertController，苹果建议：*UIActionSheet is deprecated. Use UIAlertController with a preferredStyle of UIAlertControllerStyleActionSheet instead*。（使用UIActionSheet Xcode就会报deprecate的警告，挺烦的）
[ACActionSheet][1]是仿微信效果的，简洁清新，方便好用 

>  GitHub:     https://github.com/GardenerYun

> Email:      gardeneryun@foxmail.com

> 简书博客地址: http://www.jianshu.com/users/8489e70e237d/latest_articles

>  如有问题或建议请联系我，我会马上解决问题~ (ง •̀_•́)ง**



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
 
