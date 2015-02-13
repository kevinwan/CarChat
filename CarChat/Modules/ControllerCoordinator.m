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
#import "ServerPolicyViewController.h"
#import "InviteActivityDetailViewController.h"
#import "InviteViewController.h"
#import "AppDelegate.h"
#import "UserOwningActivitiesViewController.h"
#import "UserJoiningActivitiesViewController.h"
#import "FollowingViewController.h"
#import "FollowerViewController.h"
#import "PersonalProfileViewController.h"
#import "UploadCertifyProfileViewController.h"
#import "UserCreatedActivityViewController.h"
#import "UserDetailViewController.h"
#import "EditActivityViewController.h"
#import "ParticipantsViewController.h"
#import "SettingViewController.h"

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
const NSInteger kFromMainActivitiesVCCreateButtonTag = 305;
const NSInteger ShowInviteDetailFromSomeWhereTag = 400;
const NSInteger InviteDetailIgnoreButonItemTag = 401;
const NSInteger InviteDetailJoinButtonItemTag = 402;
const NSInteger MyActivityCellTag = 500;
const NSInteger MyFollowingCellTag = 501;
const NSInteger MyFollowerCellTag = 502;
const NSInteger MyEditProfileTag = 503;
const NSInteger kShowUploadPlateFromSomewhereTag = 504;
const NSInteger kMyOwningActivityButtonTag = 505;
const NSInteger kMyJoiningActivityButtonTag = 506;
const NSInteger kMyFollowingButtonTag = 507;
const NSInteger kMySettingButtonTag = 508;
const NSInteger kShowParticipantsTag = 600;
const NSInteger kParticipantsCellTag = 601;

@implementation ControllerCoordinator

+ (void)goNextFrom:(UIViewController *)vc
           whitTag:(NSInteger)tag
        andContext:(id)context
{
    switch (tag) {
        case RegisterRegisterButtonTag:
        {
            PersonalProfileViewController * profileVC = [[PersonalProfileViewController alloc]init];
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:profileVC];
            [vc.navigationController pushViewController:nav
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
            [currentContainer presentViewController:loginNav
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
            
            UINavigationController * completeInfoNav = [[UINavigationController alloc]initWithRootViewController:[[PersonalProfileViewController alloc]init]];
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
            EditActivityViewController * edit = [[EditActivityViewController alloc]initWithActivity:(ActivityModel *)context];
            [vc.navigationController pushViewController:edit animated:YES];
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
        case kFromMainActivitiesVCCreateButtonTag:
        {
            [vc.navigationController pushViewController:[[EditActivityViewController alloc]init] animated:YES];
        }
            break;
        case MyActivityCellTag:
        {
            [vc.navigationController pushViewController:[[UserCreatedActivityViewController alloc]initWithActivity:(ActivityModel *)context] animated:YES];
        }
            break;
        case MyFollowerCellTag:
        {
            [vc.navigationController pushViewController:[[UserDetailViewController alloc]initWithUserId:(NSString *)context] animated:YES];
        }
            break;
        case MyFollowingCellTag:
        {
            [vc.navigationController pushViewController:[[UserDetailViewController alloc]initWithUserId:(NSString *)context] animated:YES];
        }
            break;
        case MyEditProfileTag:
        {
            [vc.navigationController pushViewController:[[PersonalProfileViewController alloc]initWithUserModel:(UserModel *)context] animated:YES];
        }
            break;
        case kShowUploadPlateFromSomewhereTag:
        {
            UploadCertifyProfileViewController *uploadVC = [[UploadCertifyProfileViewController alloc]init];
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:uploadVC];
            [vc.navigationController presentViewController:nav animated:YES completion:nil];
        }
            break;
        case kMyFollowingButtonTag:
        {
            [vc.navigationController pushViewController:[[FollowingViewController alloc]initWithUserId:(NSString *)context] animated:YES];
        }
            break;
        case kMyOwningActivityButtonTag:
        {
            [vc.navigationController pushViewController:[[UserOwningActivitiesViewController alloc]initWithUserId:(NSString *)context] animated:YES];
        }
            break;
        case kMyJoiningActivityButtonTag:
        {
            [vc.navigationController pushViewController:[[UserJoiningActivitiesViewController alloc]initWithUserId:(NSString *)context] animated:YES];
        }
            break;
        case kMySettingButtonTag:
        {
            [vc.navigationController pushViewController:[[SettingViewController alloc]init] animated:YES];
        }
            break;
        case kShowParticipantsTag:
        {
            ParticipantsViewController * p = [[ParticipantsViewController alloc]initWithAvtivityId:(NSString *)context];
            [vc.navigationController pushViewController:p animated:YES];
        }
            break;
        case kParticipantsCellTag:
        {
            [vc.navigationController pushViewController:[[UserDetailViewController alloc]initWithUserId:(NSString *)context] animated:YES];
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
