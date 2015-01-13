//
//  RegisterViewController.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *verifyCode;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation RegisterViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"注册";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Interaction
- (IBAction)getVerifyCode:(id)sender
{
    
}

- (IBAction)registerAction:(id)sender
{
    [ControllerCoordinator goNextFrom:self
                              whitTag:RegisterRegisterButtonTag
                           andContext:nil];
}

- (IBAction)checkIAgreePolicy:(UIButton *)sender
{
    if (sender.tag != 0) {
        sender.titleLabel.text = @"☐";
        sender.tag = 0;
    }
    else {
        sender.titleLabel.text = @"✓";
        sender.tag = 1;
    }
}

- (IBAction)serverPolicy:(id)sender
{
    
}

@end
