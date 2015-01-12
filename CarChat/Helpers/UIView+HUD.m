//
//  UIView+HUD.m
//  CarChat
//
//  Created by Develop on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UIView+HUD.h"

@implementation UIView (HUD)

- (void)showLoading:(NSString *)loading
{
    [self showLoading:loading blockGesture:YES];
}

- (void)showLoading:(NSString *)loading blockGesture:(BOOL)shouldBlock
{
    [self showLoading:loading blockGesture:shouldBlock whenDone:nil];
}

- (void)showLoading:(NSString *)loading blockGesture:(BOOL)shouldBlock whenDone:(MBProgressHUDCompletionBlock)block
{
    MBProgressHUD * hud = [[MBProgressHUD alloc]initWithView:self];
    [hud setMode:MBProgressHUDModeIndeterminate];
    [hud setAnimationType:MBProgressHUDAnimationZoom];
    hud.labelText = loading.length ? loading : @"";
    [hud setMinShowTime:.2f];
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud setUserInteractionEnabled:shouldBlock];
    [hud setCompletionBlock:block];
    [self addSubview:hud];
    [hud show:YES];
}

- (void)showTip:(NSString *)tip
{
    [self showTip:tip whenDone:nil];
}

- (void)showTip:(NSString *)tip whenDone:(MBProgressHUDCompletionBlock)block
{
    MBProgressHUD * hud = [[MBProgressHUD alloc]initWithView:self];
    [hud setMode:MBProgressHUDModeText];
    hud.labelText = tip;
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud setCompletionBlock:block];
    [self addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:2.f];
}

- (void)hideHud
{
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
}

@end
