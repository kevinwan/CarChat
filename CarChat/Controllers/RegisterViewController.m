//
//  RegisterViewController.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "RegisterViewController.h"
#import "NSString+Helpers.h"

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRegisterButton) name:UITextFieldTextDidChangeNotification object:nil];
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
}

#pragma mark - User Interaction
- (IBAction)getVerifyCode:(id)sender
{
    
}

- (IBAction)registerAction:(id)sender
{
    if (!self.acceptServerPolicy) {
        [self showTip:@"请阅读并同意服务条款"];
        return;
    }
    
    [ControllerCoordinator goNextFrom:self
                              whitTag:RegisterRegisterButtonTag
                           andContext:nil];
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

#pragma mark - UITextFieldNotify
- (void)updateRegisterButton
{
    [self.registerButton setEnabled:[self allFieldTexted]];
}

#pragma mark - Internal Helper
- (BOOL)allFieldTexted
{
    return ![self.phoneNumber.text isBlank] && ![self.verifyCode.text isBlank] && ![self.password.text isBlank];
}
@end
