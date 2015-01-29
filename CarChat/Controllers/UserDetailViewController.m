//
//  UserDetailViewController.m
//  CarChat
//
//  Created by Develop on 15/1/22.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UserDetailViewController.h"
#import "UserModel.h"
#import "FollowingViewController.h"
#import "FollowerViewController.h"
#import "UserActivitiesViewController.h"
#import "UserProfileCard.h"
#import "UIView+frame.h"
#import "GetUserInfoParameter.h"

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
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiGetUserInfo];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiGetUserInfo];
    
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
        self.user = response.object;
        [self setupContentView];
    }
}

#pragma mark - Internal Helper
- (void)setupContentView
{
    UserProfileCard * card = [UserProfileCard view];
    [card layoutWithUser:self.user];
    [self.view addSubview:card];
    [card setRelationshipTouched:^{
        // TODO: follow sb or unfollow sb
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
