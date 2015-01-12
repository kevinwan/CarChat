//
//  LoginViewController.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"登录";
    
    [self setLeftNavigationBarItem:@"取消" target:self andAction:@selector(dismissSelf)];
    [self setRightNavigationBarItem:@"注册" target:self andAction:@selector(goRegister)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Interaction
- (IBAction)loginButtonTapped:(id)sender {
    
    [self dismissSelf];
}

- (IBAction)forgetPWDButtonTapped:(id)sender {
    
    [ControllerCoordinator goNextFrom:self whitTag:LoginForgetButtonTag andContext:nil];
}

#pragma Internal Helper
- (void)goRegister
{
    [ControllerCoordinator goNextFrom:self whitTag:LoginRegisterButtonTag andContext:nil];
}

@end
