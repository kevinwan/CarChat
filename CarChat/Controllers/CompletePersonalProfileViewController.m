//
//  CompletePersonalProfileViewController.m
//  CarChat
//
//  Created by Jia Zhao on 2/14/15.
//  Copyright (c) 2015 GongPingJia. All rights reserved.
//

#import "CompletePersonalProfileViewController.h"
#import "GetActivityWithInviteCodeParameter.h"
#import "CCStatusManager.h"

@implementation CompletePersonalProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setLeftNavigationBarItem:@"" target:nil andAction:nil];
}

- (void)dealloc
{
    GetActivityWithInviteCodeParameter * p = (GetActivityWithInviteCodeParameter *)[ParameterFactory parameterWithApi:ApiGetActivityWithInviteCode];
    p.inviteCode = [[CCStatusManager defaultManager] verifyedInviteCode];
    [[CCNetworkManager defaultManager] requestWithParameter:p];
}

@end
