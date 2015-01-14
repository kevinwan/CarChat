//
//  ControllerCoordinator.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ControllerCoordinator.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "CompletePersonalInfoViewController.h"
#import "ActivityIntroductViewController.h"
#import "ServerPolicyViewController.h"

const NSInteger ShowLoginFromSomeWhereTag = 1;
const NSInteger RegisterRegisterButtonTag = 101;
const NSInteger LoginLoginButtonTag = 200;
const NSInteger LoginForgetButtonTag = 201;
const NSInteger LoginRegisterButtonTag = 202;
const NSInteger LoginForgetResetDoneTag = 203;
const NSInteger ShowCompleteInfoFromSomeWhereTag = 204;
const NSInteger ShowServerPolicyTag = 205;
const NSInteger SuggestActivitiesSelectItem = 300;

@implementation ControllerCoordinator

+ (void)goNextFrom:(UIViewController *)vc
           whitTag:(NSInteger)tag
        andContext:(id)context
{
    switch (tag) {
        case RegisterRegisterButtonTag:
        {
            CompletePersonalInfoViewController * complete = [[CompletePersonalInfoViewController alloc]init];
            [vc.navigationController pushViewController:complete
                                               animated:YES];
        }
            break;
        case LoginLoginButtonTag:
        {
            [vc.navigationController dismissViewControllerAnimated:YES
                                                        completion:nil];
        }
            break;
        case LoginForgetButtonTag:
        {
            ForgetPasswordViewController * forget = [[ForgetPasswordViewController alloc]init];
            [vc.navigationController pushViewController:forget
                                               animated:YES];
        }
            break;
        case LoginRegisterButtonTag:
        {
            if (vc.navigationController) {
                RegisterViewController * regVC = [[RegisterViewController alloc]init];
                [vc.navigationController pushViewController:regVC
                                                   animated:YES];
            }
            else return;
        }
            break;
        case LoginForgetResetDoneTag:
        {
            [vc.navigationController popViewControllerAnimated:YES];
        }
            break;
        case ShowLoginFromSomeWhereTag:
        {
            UIViewController * currentContainer = vc;
            if (vc.navigationController) {
                currentContainer = vc.navigationController;
            }
            LoginViewController * login = [[LoginViewController alloc] init];
            UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:login];
            [vc presentViewController:loginNav
                             animated:YES
                           completion:nil];
        }
            break;
        case ShowCompleteInfoFromSomeWhereTag:
        {
            UIViewController *currentTopContainer = vc;
            if (vc.navigationController) {
                currentTopContainer = vc.navigationController;
            }
            
            UINavigationController * completeInfoNav = [[UINavigationController alloc]initWithRootViewController:[[CompletePersonalInfoViewController alloc]init]];
            [currentTopContainer presentViewController:completeInfoNav
                                              animated:YES
                                            completion:nil];
        }
            break;
        case ShowServerPolicyTag:
        {
            ServerPolicyViewController * sp = [[ServerPolicyViewController alloc]init];
            UINavigationController * spNav = [[UINavigationController alloc]initWithRootViewController:sp];
            
            UIViewController *currentTopContainer = vc;
            if (vc.navigationController) {
                currentTopContainer = vc.navigationController;
            }
            [currentTopContainer presentViewController:spNav
                                              animated:YES
                                            completion:nil];
        }
            break;
        case SuggestActivitiesSelectItem:
        {
            ActivityIntroductViewController * detail = [[ActivityIntroductViewController alloc]initWithActivity:( ActivityModel *)context];
            [vc.navigationController pushViewController:detail
                                               animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
