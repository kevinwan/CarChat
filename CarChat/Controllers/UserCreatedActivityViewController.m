//
//  UserCreatedActivityViewController.m
//  CarChat
//
//  Created by Develop on 15/1/21.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UserCreatedActivityViewController.h"
#import "UserCreatActivityDescriptionView.h"
#import "CommentViewController.h"
#import "UIView+frame.h"
#import "UserModel+Helper.h"
#import "ActivityInvitator.h"

@interface UserCreatedActivityViewController ()

@property (nonatomic, strong) ActivityModel * activity;
@property (nonatomic, strong) ActivityInvitator * invitator;

@end

@implementation UserCreatedActivityViewController

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
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"活动详情";
    
    if ([self.activity.owner.identifier isEqualToString:[UserModel currentUserId]]) {
        // 当前用户创建的活动
        [self setRightNavigationBarItem:@"邀请" target:self andAction:@selector(invite)];
    }
    
    [self setupContentView];
}

#pragma mark - User Interaction
- (void)invite
{
    self.invitator = [[ActivityInvitator alloc]initWithActivity:self.activity onViewController:self];
    [self.invitator show];
}


#pragma mark - Internal Helper
- (void)setupContentView
{
    UserCreatActivityDescriptionView * view = [UserCreatActivityDescriptionView view];
    [view layoutWithModel:self.activity];
    __weak typeof(self) _weakRef = self;
    [view setViewParticipantsBlock:^{
        [ControllerCoordinator goNextFrom:_weakRef whitTag:kShowParticipantsTag andContext:_weakRef.activity.identifier];
    }];
    [self.view addSubview:view];
    
    CommentViewController * comment = [[CommentViewController alloc]initWithActivityId:self.activity.identifier];
    [comment.view setFrame:self.view.bounds];
    [comment setListHeaderView:view];
    [self addChildViewController:comment];
    [self.view addSubview:comment.view];
    [comment didMoveToParentViewController:self];
}

@end
