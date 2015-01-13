//
//  ForgetPasswordViewController.m
//  CarChat
//
//  Created by Develop on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "NSString+Helpers.h"

@interface ForgetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *verifyCode;
@property (weak, nonatomic) IBOutlet UITextField *newerPwd;

@end

@implementation ForgetPasswordViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Interaction
- (IBAction)getVerifyCode:(id)sender
{
    if ([self.phoneNumber.text isMobileNumber]) {
        // go request api
    }
    else {
        [self showTip:@"请输入正确的手机号"];
    }
}

- (IBAction)requestResetPWD:(id)sender
{
    if (![self allFieldsTexted]) {
        [self showTip:@"请输入完整"];
        return;
    }
    
    [ControllerCoordinator goNextFrom:self
                              whitTag:LoginForgetResetDoneTag
                           andContext:nil];
}

#pragma mark - Internal Helper
- (BOOL)allFieldsTexted
{
    return ![self.phoneNumber.text isBlank] && ![self.verifyCode.text isBlank] && ![self.newerPwd.text isBlank];
}

@end
