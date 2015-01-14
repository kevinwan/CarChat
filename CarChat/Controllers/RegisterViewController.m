//
//  RegisterViewController.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "RegisterViewController.h"
#import "NSString+Helpers.h"
#import "RegisterParameter.h"
#import "GetVerifySMSParameter.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *verifyCode;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (nonatomic, assign) BOOL acceptServerPolicy;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation RegisterViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateRegisterButton)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self
                                            forApi:ApiRegister];
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiGetVerifySMS];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lifecycle
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiRegister];
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiGetVerifySMS];
}

#pragma mark - CCNetworkResponse
- (void)didGetResponseNotification:(NSNotification *)response
{
    [self hideHud];
    if ([response.object isKindOfClass:[NSError class]]) {
        // fail
    }
    else {
        // successful
        ABCParameter * parameter = response.userInfo[ResponseUserInfoParameterKey];
        NSString * api = parameter.api;
        if (api == ApiRegister) {
            [self showTip:@"注册成功"  whenDone:^{
                [ControllerCoordinator goNextFrom:self
                                          whitTag:RegisterRegisterButtonTag
                                       andContext:nil];
            }];
        }
        else if (api == ApiGetVerifySMS) {
            [self showTip:@"获取验证码成功"];
        }
        
    }
}

#pragma mark - UITextFieldNotify
- (void)updateRegisterButton
{
    [self.registerButton setEnabled:[self allFieldTexted]];
}

#pragma mark - User Interaction
- (IBAction)getVerifyCode:(id)sender
{
    [self showLoading:nil];
    GetVerifySMSParameter * parameter = (GetVerifySMSParameter *)[ParameterFactor parameterWithApi:ApiGetVerifySMS];
    [parameter setPhone:self.phoneNumber.text];
    [[CCNetworkManager defaultManager] requestWithParameter:parameter];
}

- (IBAction)registerAction:(id)sender
{
    if (!self.acceptServerPolicy) {
        [self showTip:@"请阅读并同意服务条款"];
        return;
    }
    
    [self showLoading:@"正在注册"];
    
    RegisterParameter * reg = (RegisterParameter *)[ParameterFactor parameterWithApi:ApiRegister];
    [reg setPhone:self.phoneNumber.text];
    [reg setVerifyCode:self.verifyCode.text];
    [reg setPwd:self.password.text];
    [[CCNetworkManager defaultManager] requestWithParameter:reg];
}

- (IBAction)checkIAgreePolicy:(UIButton *)sender
{
    if (sender.tag != 0) {
        [sender setBackgroundColor:[UIColor redColor]];
        sender.tag = 0;
        self.acceptServerPolicy = NO;
    }
    else {
        [sender setBackgroundColor:[UIColor greenColor]];
        sender.tag = 1;
        self.acceptServerPolicy = YES;
    }
}

- (IBAction)serverPolicy:(id)sender
{
    [ControllerCoordinator goNextFrom:self
                              whitTag:ShowServerPolicyTag
                           andContext:nil];
}

#pragma mark - Internal Helper
- (BOOL)allFieldTexted
{
    return ![self.phoneNumber.text isBlank] && ![self.verifyCode.text isBlank] && ![self.password.text isBlank];
}
@end
