//
//  AbstractViewController.h
//  CarChat
//
//  Created by Develop on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbstractViewController : UIViewController

- (void)showLoading:(NSString *)loading;
- (void)showLoading:(NSString *)loading blockGesture:(BOOL)shouldBlock;
- (void)showLoading:(NSString *)loading blockGesture:(BOOL)shouldBlock whenDone:(void (^)(void))block;

- (void)showTip:(NSString *)tip;
- (void)showTip:(NSString *)tip whenDone:(void (^)(void))block;

- (void)hideHud;

- (void)setLeftNavigationBarItem:(NSString *)title target:(id)target andAction:(SEL)action;
- (void)setRightNavigationBarItem:(NSString*)title target:(id)target andAction:(SEL)action;

- (void)dismissSelf;
@end
