//
//  ForgetPasswordViewController.m
//  CarChat
//
//  Created by Develop on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "GetVerifySMSParameter.h"
#import "ResetPasswordParameter.h"
#import "NSString+Helpers.h"

@interface ForgetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *verifyCode;
@property (weak, nonatomic) IBOutlet UITextField *newerPwd;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@end

@implementation ForgetPasswordViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateResetButton)
                                                 name:UITextFieldTextDidChangeNotification object:nil];

    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self
                                            forApi:ApiGetVerifySMS];
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self
                                            forApi:ApiResetPassword];
}

- (void)didReceiveMemoryWarning
{
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
                                               forApi:ApiGetVerifySMS];
    [[CCNetworkManager defaultManager] removeObserver:self
                                               forApi:ApiResetPassword];
}

#pragma mark - User Interaction
- (IBAction)getVerifyCode:(id)sender
{
    if ([self.phoneNumber.text isMobileNumber]) {
        [self showLoading:nil];
        GetVerifySMSParameter * parameter = (GetVerifySMSParameter *)[ParameterFactory parameterWithApi:ApiGetVerifySMS];
        [parameter setPhone:self.phoneNumber.text];
        [[CCNetworkManager defaultManager] requestWithParameter:parameter];
    }
    else {
        [self showTip:@"请检查手机号码"];
    }
}

- (IBAction)requestResetPWD:(id)sender
{
    ResetPasswordParameter * parameter = (ResetPasswordParameter *)[ParameterFactory parameterWithApi:ApiResetPassword];
    [parameter setPhone:self.phoneNumber.text];
    [parameter setVerifyCode:self.verifyCode.text];
    [parameter setTheNewPassword:self.newerPwd.text];
    
    [[CCNetworkManager defaultManager] requestWithParameter:parameter];
}

#pragma mark - CCNetworkResponse
- (void)didGetResponseNotification:(ConcreteResponseObject *)response
{
    [self hideHud];
    if (response.error) {
        // failed
    }
    else {
        NSString * api = response.api;
        if (api == ApiGetVerifySMS) {
            [self showTip:@"获取验证码成功"];
        }
        else if (api == ApiResetPassword) {
            [self showTip:@"密码重置成功，请重新登录" whenDone:^{
                [ControllerCoordinator goNextFrom:self
                                          whitTag:LoginForgetResetDoneTag
                                       andContext:nil];
            }];
        }
    }
}

#pragma mark - UITextFieldNotify
- (void)updateResetButton
{
    [self.resetButton setEnabled: [self allFieldsTexted]];
}

#pragma mark - Internal Helper
- (BOOL)allFieldsTexted
{
    return ![self.phoneNumber.text isBlank] && ![self.verifyCode.text isBlank] && ![self.newerPwd.text isBlank];
}

@end
