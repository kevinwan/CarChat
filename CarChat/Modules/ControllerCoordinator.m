//
//  ControllerCoordinator.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ControllerCoordinator.h"
#import "LoginViewController.h"

const NSInteger RegisterHaveCarButtonTag = 100;
const NSInteger RegisterDontHaveCarButtonTag = 101;
const NSInteger LoginLoginButtonTag = 200;
const NSInteger LoginForgetButtonTag = 201;
const NSInteger LoginRegisterButtonTag = 202;
const NSInteger ShowLoginFromSomeWhereTag = 300;

@implementation ControllerCoordinator

+ (void)goNextFrom:(UIViewController *)vc
           whitTag:(NSInteger)tag
        andContext:(void *)context
{
    switch (tag) {
        case RegisterHaveCarButtonTag:
            
            break;
        case RegisterDontHaveCarButtonTag:
            
            break;
        case LoginLoginButtonTag:
            
            break;
        case LoginForgetButtonTag:
            
            break;
        case LoginRegisterButtonTag:
            
            break;
        case ShowLoginFromSomeWhereTag:
        {
            UIViewController * currentContainer = vc;
            if (vc.navigationController) {
                currentContainer = vc.navigationController;
            }
            LoginViewController * login = [[LoginViewController alloc] init];
            UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:login];
            [vc presentViewController:loginNav animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

@end
