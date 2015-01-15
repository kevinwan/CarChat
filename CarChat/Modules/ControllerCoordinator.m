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
#import "InviteActivityDetailViewController.h"
#import "InviteViewController.h"
#import "AppDelegate.h"
#import "MyActivitiesViewController.h"
#import "FollowingViewController.h"
#import "FollowerViewController.h"

const NSInteger ShowLoginFromSomeWhereTag = 1;
const NSInteger RegisterRegisterButtonTag = 101;
const NSInteger LoginLoginButtonTag = 200;
const NSInteger LoginForgetButtonTag = 201;
const NSInteger LoginRegisterButtonTag = 202;
const NSInteger LoginForgetResetDoneTag = 203;
const NSInteger ShowCompleteInfoFromSomeWhereTag = 204;
const NSInteger ShowServerPolicyTag = 205;
const NSInteger SuggestActivitiesSelectItem = 300;
const NSInteger CreatedActivityCloseButtonItemTag = 301;
const NSInteger CreatedActivityInviteButtonItemTag = 302;
const NSInteger InviteCloseButtonItemTag = 303;
const NSInteger InviteInviteButtonItemTag = 304;
const NSInteger ShowInviteDetailFromSomeWhereTag = 400;
const NSInteger InviteDetailIgnoreButonItemTag = 401;
const NSInteger InviteDetailJoinButtonItemTag = 402;
const NSInteger MyActivityCellTag = 500;
const NSInteger MyFollowingCellTag = 501;
const NSInteger MyFollowerCellTag = 502;

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
        case CreatedActivityCloseButtonItemTag:
        {
            [vc.navigationController popViewControllerAnimated:YES];
        }
            break;
        case CreatedActivityInviteButtonItemTag:
        {
            InviteViewController * invite = [[InviteViewController alloc]initWithActivity:(ActivityModel *)context];
            UINavigationController * inviteNav = [[UINavigationController alloc]initWithRootViewController:invite];
            [vc.navigationController presentViewController:inviteNav
                                                  animated:YES
                                                completion:nil];
        }
            break;
        case InviteCloseButtonItemTag:
        {
            [vc.navigationController dismissViewControllerAnimated:YES
                                                        completion:nil];
        }
            break;
        case InviteInviteButtonItemTag:
        {
            
        }
            break;
        case ShowInviteDetailFromSomeWhereTag:
        {
            InviteActivityDetailViewController * detail = [[InviteActivityDetailViewController alloc]initWithActivity:(ActivityModel *)context];
            UINavigationController * detailNav = [[UINavigationController alloc]initWithRootViewController:detail];
            UIViewController * activeVC = [self activityViewController];
            [activeVC presentViewController:detailNav
                                   animated:YES
                                 completion:nil];
        }
            break;
        case InviteDetailIgnoreButonItemTag:
        {
            [vc.navigationController dismissViewControllerAnimated:YES
                                                        completion:nil];
        }
            break;
        case InviteDetailJoinButtonItemTag:
        {
            [vc.navigationController dismissViewControllerAnimated:YES
                                                        completion:nil];
        }
            break;
        case MyActivityCellTag:
        {
            MyActivitiesViewController * myActivity = [[MyActivitiesViewController alloc]init];
            [vc.navigationController pushViewController:myActivity
                                               animated:YES];
        }
            break;
        case MyFollowerCellTag:
        {
            FollowerViewController * following = [[FollowerViewController alloc]init];
            [vc.navigationController pushViewController:following
                                               animated:YES];
        }
            break;
        case MyFollowingCellTag:
        {
            FollowingViewController * follower = [[FollowingViewController alloc]init];
            [vc.navigationController pushViewController:follower
                                               animated:YES];
        }
            break;
        default:
            break;
    }
}


#pragma mark - Internal Helper
+ (UIViewController *)activityViewController
{
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if(tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            activityViewController = nextResponder;
        }
        else
        {
            activityViewController = window.rootViewController;
        }
    }
    
    return activityViewController;
}

@end
