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
}

#pragma mark - User Interaction
- (IBAction)getVerifyCode:(id)sender
{
    if ([self.phoneNumber.text isMobileNumber]) {
        // go request api
    }
    else {
        [self showTip:@"请检查手机号码"];
    }
}

- (IBAction)requestResetPWD:(id)sender
{
    
    [ControllerCoordinator goNextFrom:self
                              whitTag:LoginForgetResetDoneTag
                           andContext:nil];
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
