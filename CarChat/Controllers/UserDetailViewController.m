//
//  UserDetailViewController.m
//  CarChat
//
//  这个是用户主页（当前用户或任意用户）
//  包含三个controller，分别显示用户参加（或创建）的活动，用户的关注者，和粉丝。
//  还包含一个头部卡片，用来显示用户的头像，性别，认证情况，还有三个列表的切换按钮。
//
//  Created by Develop on 15/1/22.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UserDetailViewController.h"
#import "UserModel+helper.h"
#import "FollowingViewController.h"
#import "FollowerViewController.h"
#import "UserActivitiesViewController.h"
#import "UserProfileCard.h"
#import "UIView+frame.h"
#import "GetUserInfoParameter.h"
#import "CCStatusManager.h"
#import "FollowUserParameter.h"
#import "UnfollowUserParameter.h"


@interface UserDetailViewController ()

@property (nonatomic, copy) NSString * userId; // 传入参数
/*
                                   经     \\
                                   过     //
                                   查     \\
                                   寻     //
                                          V
*/
@property (nonatomic, strong) UserModel * user; // 查询到的user对象
@property (nonatomic, strong) UserActivitiesViewController * activityVC;
@property (nonatomic, strong) FollowingViewController * followingVC;
@property (nonatomic, strong) FollowerViewController * followerVC;

@end

@implementation UserDetailViewController

#pragma mark - Lifecycle
- (instancetype)initWithUserId:(NSString *)userId
{
    if (self = [super init]) {
        self.userId = userId;
    }
    return self;
}

- (void)dealloc
{
    [[CCNetworkManager defaultManager] removeObserver:self
                                               forApi:ApiGetUserInfo];
    [[CCNetworkManager defaultManager] removeObserver:self
                                               forApi:ApiFollowUser];
    [[CCNetworkManager defaultManager] removeObserver:self
                                               forApi:ApiUnfollowUser];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self
                                            forApi:ApiGetUserInfo];
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self
                                            forApi:ApiFollowUser];
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self
                                            forApi:ApiUnfollowUser];
    
    [self requestUserInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CCNetworkResponse
- (void)didGetResponseNotification:(ConcreteResponseObject *)response
{
    [self hideHud];
    if (response.error) {
        // 出错
        [self showTip:response.error.localizedDescription];
    }
    else {
        // 成功
        NSString * api = response.parameter.api;
        if (api == ApiGetUserInfo) {
            self.user = response.object;
            [self setupContentView];
        }
        else if (api == ApiFollowUser) {
            [self showTip:@"关注成功"];
        }
        else if (api == ApiUnfollowUser) {
            [self showTip:@"取消关注成功"];
        }
    }
}

#pragma mark - Public APIs
- (UserModel *)user
{
    return _user;
}

#pragma mark - Internal Helper
- (void)setupContentView
{
    UserProfileCard * card = [UserProfileCard view];
    [card layoutWithUser:self.user];
    [card.relationshipButton setHidden:[UserModel isCurrentUserId:self.user.identifier]];
    [self.view addSubview:card];
    [card setRelationshipTouched:^{
        [self showLoading:@""];
        if ([UserModel userIsCurrentUserFollowee:self.user]) {
            // 关注用户，取关
            UnfollowUserParameter * p = (UnfollowUserParameter *)[ParameterFactory parameterWithApi:ApiUnfollowUser];
            [p setUserIdentifier:self.user.identifier];
            [[CCNetworkManager defaultManager] requestWithParameter:p];
        }
        else {
            // 未关注用户，关注
            FollowUserParameter *p = (FollowUserParameter *)[ParameterFactory parameterWithApi:ApiFollowUser];
            [p setUserIdentifier:self.user.identifier];
            [[CCNetworkManager defaultManager] requestWithParameter:p];
        }
    }];
    
    self.activityVC = [[UserActivitiesViewController alloc]initWithUserId:self.userId];
    self.followingVC = [[FollowingViewController alloc]initWithUserId:self.userId];
    self.followerVC = [[FollowerViewController alloc]initWithUserId:self.userId];
    CGRect restFrame = self.view.bounds;
    restFrame.origin.y = card.y + card.height;
    restFrame.size.height = restFrame.size.height - card.y - card.height;
    [self.activityVC.view setFrame:restFrame];
    [self.followingVC.view setFrame:restFrame];
    [self.followerVC.view setFrame:restFrame];
    [self addChildViewController:self.followerVC];
    [self.view addSubview:self.followerVC.view];
    [self.followerVC didMoveToParentViewController:self];
    [self addChildViewController:self.followingVC];
    [self.view addSubview:self.followingVC.view];
    [self.followingVC didMoveToParentViewController:self];
    [self addChildViewController:self.activityVC];
    [self.view addSubview:self.activityVC.view];
    [self.activityVC didMoveToParentViewController:self];
    
    __weak typeof(self) weakRef = self;
    [card setActivityTouched:^{
        [weakRef.view bringSubviewToFront:weakRef.activityVC.view];
    }];
    [card setFollowingTouched:^{
        [weakRef.view bringSubviewToFront:weakRef.followingVC.view];
    }];
    [card setFollowerTouched:^{
        [weakRef.view bringSubviewToFront:weakRef.followerVC.view];
    }];
}

- (void)requestUserInfo
{
    [self showLoading:@""];
    GetUserInfoParameter * p = (GetUserInfoParameter *)[ParameterFactory parameterWithApi:ApiGetUserInfo];
    p.userIdentifier = self.userId;
    [[CCNetworkManager defaultManager] requestWithParameter:p];
}

@end
