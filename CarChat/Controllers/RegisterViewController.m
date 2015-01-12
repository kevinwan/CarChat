//
//  RegisterViewController.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "RegisterViewController.h"
#import "ControllerCoordinator.h"


@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UIButton *haveCarButton;
@property (weak, nonatomic) IBOutlet UIButton *notHaveCarButton;

@end

@implementation RegisterViewController

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
- (IBAction)didHaveCar:(UIButton *)sender {
    if (sender.tag == 1) {
        [ControllerCoordinator goNextFrom:self
                                  whitTag:RegisterHaveCarButtonTag
                               andContext:nil];
    }
    else {
        [ControllerCoordinator goNextFrom:self
                                  whitTag:RegisterDontHaveCarButtonTag
                               andContext:nil];
    }
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
