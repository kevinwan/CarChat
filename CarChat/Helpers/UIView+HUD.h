//
//  UIView+HUD.h
//  CarChat
//
//  Created by Develop on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

@interface UIView (HUD)

- (void)showLoading:(NSString *)loading;
- (void)showLoading:(NSString *)loading blockGesture:(BOOL)shouldBlock;
- (void)showLoading:(NSString *)loading blockGesture:(BOOL)shouldBlock whenDone:(MBProgressHUDCompletionBlock)block;

- (void)showTip:(NSString *)tip;
- (void)showTip:(NSString *)tip whenDone:(MBProgressHUDCompletionBlock)block;

- (void)hideHud;

@end
