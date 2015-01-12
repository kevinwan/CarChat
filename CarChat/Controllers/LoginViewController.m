//
//  LoginViewController.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "LoginViewController.h"
#import "ControllerCoordinator.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Interaction
- (IBAction)loginButtonTapped:(id)sender {
    
    [ControllerCoordinator goNextFrom:self whitTag:LoginLoginButtonTag andContext:nil];
}

- (IBAction)forgetPWDButtonTapped:(id)sender {
    
    [ControllerCoordinator goNextFrom:self whitTag:LoginForgetButtonTag andContext:nil];
}

- (IBAction)registerButtonTapped:(id)sender {
    
    [ControllerCoordinator goNextFrom:self whitTag:LoginRegisterButtonTag andContext:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
