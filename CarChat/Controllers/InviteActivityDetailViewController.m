//
//  InviteActivityDetailViewController.m
//  CarChat
//
//  Created by Develop on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "InviteActivityDetailViewController.h"
#import "UserCreatActivityDescriptionView.h"
#import "ReplyInvitationParameter.h"

@interface InviteActivityDetailViewController ()

@property (nonatomic, strong) ActivityModel * activity;

@end

@implementation InviteActivityDetailViewController

#pragma mark - Lifecycle
- (instancetype)initWithActivity:(ActivityModel *)activity
{
    if (self = [super init]) {
        self.activity = activity;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiReplyInvitation];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"收到邀请";
    [self setLeftNavigationBarItem:@"忽略" target:self andAction:@selector(ignore)];
    [self setRightNavigationBarItem:@"加入" target:self andAction:@selector(join)];
    
    UserCreatActivityDescriptionView * view  = [UserCreatActivityDescriptionView view];
    [view layoutWithModel:self.activity];
    __weak typeof(self) _weakRef = self;
    [view setViewParticipantsBlock:^{
        [ControllerCoordinator goNextFrom:_weakRef whitTag:kShowParticipantsTag andContext:_weakRef.activity.identifier];
    }];
    [self.view addSubview:view];
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiReplyInvitation];
}

#pragma mark - CCNetworkResponse
- (void)didGetResponseNotification:(ConcreteResponseObject *)response
{
    [self hideHud];
    
    if (response.error) {
        [self showTip:response.error.localizedDescription];
    }
    else {
        // reply invitation success
        ReplyInvitationParameter * param = (ReplyInvitationParameter *)response.parameter;
        if (param.accepted) {
            [ControllerCoordinator goNextFrom:self
                                      whitTag:InviteDetailJoinButtonItemTag
                                   andContext:nil];
        }
        else {
            [ControllerCoordinator goNextFrom:self
                                      whitTag:InviteDetailIgnoreButonItemTag
                                   andContext:nil];
        }
    }
}

#pragma mark - User Interaction
- (void)ignore
{
    [self showLoading:nil];
//    ReplyInvitationParameter * p = (ReplyInvitationParameter *)[ParameterFactory parameterWithApi:ApiReplyInvitation];
//    [p setAccepted:NO];
//    [[CCNetworkManager defaultManager] requestWithParameter:p];
    [ControllerCoordinator goNextFrom:self
                              whitTag:InviteDetailIgnoreButonItemTag
                           andContext:nil];
}

- (void)join
{
    [self showLoading:nil];
    ReplyInvitationParameter * p = (ReplyInvitationParameter *)[ParameterFactory parameterWithApi:ApiReplyInvitation];
    p.invitedActivityId = self.activity.identifier;
    [p setAccepted:YES];
    [[CCNetworkManager defaultManager] requestWithParameter:p];
}

@end
