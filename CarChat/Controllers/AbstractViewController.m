//
//  AbstractViewController.m
//  CarChat
//
//  Created by Develop on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "AbstractViewController.h"
#import "UIView+HUD.h"

@interface AbstractViewController ()

@end

@implementation AbstractViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Public APIs
- (void)showLoading:(NSString *)loading
{
    [self showLoading:loading blockGesture:YES];
}
- (void)showLoading:(NSString *)loading blockGesture:(BOOL)shouldBlock
{
    [self showLoading:loading blockGesture:shouldBlock whenDone:nil];
}
- (void)showLoading:(NSString *)loading blockGesture:(BOOL)shouldBlock whenDone:(void (^)(void))block
{
    [self.view showLoading:loading blockGesture:shouldBlock whenDone:block];
}
- (void)showTip:(NSString *)tip
{
    [self showTip:tip whenDone:nil];
}
- (void)showTip:(NSString *)tip whenDone:(void (^)(void))block
{
    [self.view showTip:tip whenDone:block];
}
- (void)hideHud
{
    [self.view hideHud];
}

- (void)setLeftNavigationBarItem:(NSString *)title target:(id)target andAction:(SEL)action
{
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    [self.navigationItem setLeftBarButtonItem:item];
}
- (void)setRightNavigationBarItem:(NSString *)title target:(id)target andAction:(SEL)action
{
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    [self.navigationItem setRightBarButtonItem:item];
}

- (void)dismissSelf
{
    UIViewController * currentModalController = self;
    if (self.navigationController) {
        currentModalController = self.navigationController;
    }
    [currentModalController dismissViewControllerAnimated:YES completion:nil];
}

@end
