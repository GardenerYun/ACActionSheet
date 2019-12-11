//
//  ViewController.m
//  ACActionSheet
//
//  Created by Zhangziyun on 16/5/3.
//  Copyright © 2016年 章子云. All rights reserved.
//


#import "ViewController.h"
#import "ACActionSheet.h"
#import "UIAlertController+ACAlertView.h"

@interface ViewController () <UIActionSheetDelegate, ACActionSheetDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/** 
 *  系统 - UIActionSheet demo
 */
- (IBAction)_showUIActionSheet:(UIButton *)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"微信朋友圈" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"小视频" otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    
    [actionSheet showInView:self.view];
}

/** 
 *  系统 - UIAlertController demo
 */
- (IBAction)_showUIAlertController:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存或删除数据" message:@"删除数据将不可恢复" preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"UIAlertController - 取消");
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"UIAlertController - 删除");
    }];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"UIAlertController - 保存");
    }];

    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:saveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


/**
 *   ACActionSheet type delegate demo
 */
- (IBAction)_showACActionSheetTypeDelegate:(UIButton *)sender {

    ACActionSheet *actionSheet = [[ACActionSheet alloc] initWithTitle:@"保存或删除数据" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:@"保存",@"更改", nil];

    [actionSheet show];
}



/** 
 *   ACActionSheet type block demo 
 */
- (IBAction)_showACActionSheetTypeBlock:(UIButton *)sender {
    ACActionSheet *actionSheet = [[ACActionSheet alloc] initWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"小视频",@"拍照",@"从手机相册选择"] actionSheetBlock:^(NSInteger buttonIndex) {
        NSLog(@"ACActionSheet block - %ld",buttonIndex);
    }];
    [actionSheet show];
}

- (IBAction)_showUIAlertControllerAction:(id)sender {
    
    [[UIAlertController alertControllerWithTitle:@"提示" message:@"保持或者删除数据" cancelButtonTitle:@"取消" confirmButtonTitle:@"确定" preferredStyle:UIAlertControllerStyleAlert alertViewBlock:^(NSInteger buttonIndex) {
        NSLog(@"UIAlertController 类目 - %@",@(buttonIndex));
    }] show] ;

}


- (IBAction)_showUIAlertControllerMoreButtonAction:(id)sender {

    [[UIAlertController alertControllerWithTitle:@"提示" message:@"保持或者删除数据" cancelButtonTitle:@"取消" confirmButtonTitle:@"确定" otherButtonTitles:@[@"按钮3",@"按钮4",@"按钮5",@"按钮6"] preferredStyle:UIAlertControllerStyleAlert alertViewBlock:^(NSInteger buttonIndex) {
        NSLog(@"UIAlertController 类目 - %@",@(buttonIndex));
    }] show] ;
    
}


#pragma mark - UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"UIActionSheet - %@ %ld",[actionSheet buttonTitleAtIndex:buttonIndex],buttonIndex);
}

#pragma mark - ACActionSheet delegate
- (void)actionSheet:(ACActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"ACActionSheet delegate - %ld",buttonIndex);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
