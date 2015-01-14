//
//  LoginViewController.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginParameter.h"
#import "ValidateInviteCodeParameter.h"
#import "CCNetworkManager.h"
#import "NSString+Helpers.h"
#import "ParameterFactory.h"
#import <SCLAlertView.h>

@interface LoginViewController () <CCNetworkResponse>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLoginButton)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self
                                            forApi:ApiLogin];
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self
                                            forApi:ApiValidateInviteCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lifecycle
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextFieldTextDidChangeNotification
                                                  object:nil];
    [[CCNetworkManager defaultManager] removeObserver:self
                                               forApi:ApiLogin];
    [[CCNetworkManager defaultManager] removeObserver:self
                                               forApi:ApiValidateInviteCode];
}

#pragma mark - User Interaction
- (IBAction)loginButtonTapped:(id)sender
{
//    if ([self isPhoneNumberValid]) {
        [self showLoading:@"正在登录"];
        
        LoginParameter * parameter = (LoginParameter *)[ParameterFactory parameterWithApi:ApiLogin];
        parameter.phone = self.phoneNumber.text;
        parameter.pwd = self.password.text;
        [[CCNetworkManager defaultManager] requestWithParameter:parameter];
//    }
//    else {
//        [self showTip:@"请输入正确的手机号码"];
//    }
}

- (IBAction)forgetPWDButtonTapped:(id)sender
{
    
    [ControllerCoordinator goNextFrom:self
                              whitTag:LoginForgetButtonTag
                           andContext:nil];
}

- (void)goRegister
{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    UITextField *textField = [alert addTextField:@"输入邀请码"];
    
    [alert addButton:@"验证"
     validationBlock:^BOOL{
         return ![textField.text isBlank];
     }
         actionBlock:^(void) {
             [self showLoading:@"正在验证"];
             LOG_EXPR(textField.text);
             ValidateInviteCodeParameter * parameter = (ValidateInviteCodeParameter *)[ParameterFactory parameterWithApi:ApiValidateInviteCode];
             [parameter setInviteCode:textField.text];
             [[CCNetworkManager defaultManager] requestWithParameter:parameter];
         }];
    
    [alert showInfo:self title:nil subTitle:@"请输入您的邀请码" closeButtonTitle:@"取消" duration:.0f];
}

#pragma mark - CCNetworkResponse
- (void)didGetResponseNotification:(ConcreteResponseObject *)response
{
    [self hideHud];
    
    if (response.error != nil) {
        // failed
    }
    else {
        // successful
        NSString * api = response.api;
        if (api == ApiLogin) {
            // 登录成功
            [self showTip:@"登录成功" whenDone:^{
                [ControllerCoordinator goNextFrom:self
                                          whitTag:LoginLoginButtonTag
                                       andContext:nil];
            }];
        }
        else if (api == ApiValidateInviteCode) {
            // 验证成功
            [self showTip:@"验证成功" whenDone:^{
                [ControllerCoordinator goNextFrom:self
                                          whitTag:LoginRegisterButtonTag
                                       andContext:nil];
            }];
        }
        else {
        }
    }
}

#pragma mark - UITextFieldNotify
- (void)updateLoginButton
{
    [self.loginButton setEnabled: [self allFiledsTexted]];
}

#pragma Internal Helper
- (BOOL)allFiledsTexted
{
    return ![self.phoneNumber.text isBlank] && ![self.password.text isBlank];
}

- (BOOL)isPhoneNumberValid
{
    return [self.phoneNumber.text isMobileNumber];
}

@end
