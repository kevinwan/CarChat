//
//  LoginViewController.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginParameter.h"
#import "CCNetworkManager.h"
#import "NSString+Helpers.h"

@interface LoginViewController () <CCNetworkResponse>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"登录";
    
    [self setLeftNavigationBarItem:@"取消"
                            target:self
                         andAction:@selector(dismissSelf)];
    [self setRightNavigationBarItem:@"注册"
                             target:self
                          andAction:@selector(goRegister)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Interaction
- (IBAction)loginButtonTapped:(id)sender {
    
    if (![self allFiledsTexted]) {
        [self showTip:@"请填写完整"];
        return;
    }
    
    [self dismissSelf];
}

- (IBAction)forgetPWDButtonTapped:(id)sender {
    
    [ControllerCoordinator goNextFrom:self
                              whitTag:LoginForgetButtonTag
                           andContext:nil];
}

- (void)goRegister
{
    [ControllerCoordinator goNextFrom:self
                              whitTag:LoginRegisterButtonTag
                           andContext:nil];
}

#pragma mark - CCNetworkResponse
- (void)didGetResponseNotification:(NSNotification *)response
{
    
}

#pragma Internal Helper
- (BOOL)allFiledsTexted
{
    return ![self.phoneNumber.text isBlank] && ![self.phoneNumber.text isBlank];
}

- (BOOL)isPhoneNumberValid
{
    return [self.phoneNumber.text isMobileNumber];
}

@end
