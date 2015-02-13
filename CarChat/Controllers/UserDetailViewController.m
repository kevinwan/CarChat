//
//  UserDetailViewController.m
//  CarChat
//
//  这个是用户主页（当前用户或任意用户）
//  包含三个controller，分别显示用户参加的活动，用户的关注者，和用户创建的活动。
//  还包含一个头部卡片，用来显示用户的头像，性别，认证情况，还有三个列表的切换按钮。
//
//  Created by Develop on 15/1/22.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UserDetailViewController.h"
#import "UserModel+helper.h"
#import "FollowingViewController.h"
//#import "FollowerViewController.h"
#import "UserOwningActivitiesViewController.h"
#import "UserJoiningActivitiesViewController.h"
#import "UserProfileCard.h"
#import "UIView+frame.h"
#import "GetUserInfoParameter.h"
#import "CCStatusManager.h"
#import "FollowUserParameter.h"
#import "UnfollowUserParameter.h"

static CGFloat const kFollowButtonHeight = 40.f;
static NSInteger const kShouldFollowTag = 2;
static NSInteger const kShouldUnfollowTag = 3;


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
@property (nonatomic, strong) UserProfileCard * card;
@property (nonatomic, strong) UserOwningActivitiesViewController * owningActivityVC;
@property (nonatomic, strong) FollowingViewController * followingVC;
@property (nonatomic, strong) UserJoiningActivitiesViewController * joiningActivityVC;
@property (nonatomic, strong) UIButton * followButton;

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
    
    self.navigationItem.title = @"TA的详情";
    
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
    if (![response.parameter.uniqueId isEqualToString:self.description]) {
        return;
    }
    
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
            self.user.relationship |= RelationshipFollowing;
        }
        else if (api == ApiUnfollowUser) {
            [self showTip:@"取消关注成功"];
            self.user.relationship &= ~RelationshipFollowing;
        }
        
        [self configFollowButton];
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
    self.card = [UserProfileCard view];
    [self.card layoutWithUser:self.user];
//    [self.view addSubview:self.card];
    
    
    
    CGRect restFrame = self.view.bounds;
    self.owningActivityVC = [[UserOwningActivitiesViewController alloc]initWithUserId:self.userId];
    self.followingVC = [[FollowingViewController alloc]initWithUserId:self.userId];
    self.joiningActivityVC = [[UserJoiningActivitiesViewController alloc]initWithUserId:self.userId];
//    restFrame.origin.y = card.y + card.height;
//    restFrame.size.height = restFrame.size.height - card.y - card.height;
    [self.owningActivityVC.view setFrame:restFrame];
    [self.followingVC.view setFrame:restFrame];
    [self.joiningActivityVC.view setFrame:restFrame];
    [self addChildViewController:self.joiningActivityVC];
    [self.view addSubview:self.joiningActivityVC.view];
    [self.joiningActivityVC didMoveToParentViewController:self];
    [self addChildViewController:self.followingVC];
    [self.view addSubview:self.followingVC.view];
    [self.followingVC didMoveToParentViewController:self];
    [self addChildViewController:self.owningActivityVC];
    [self.view addSubview:self.owningActivityVC.view];
    [self.owningActivityVC didMoveToParentViewController:self];
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(_card) weakCard = self.card;
    [self.card setOwningActivityTouched:^{
        [weakSelf.view bringSubviewToFront:weakSelf.owningActivityVC.view];
        [weakSelf.followingVC setTableHeader:nil];
        [weakSelf.joiningActivityVC setTableHeader:nil];
        [weakSelf.owningActivityVC setTableHeader:weakCard];
    }];
    [self.card setFollowingTouched:^{
        [weakSelf.view bringSubviewToFront:weakSelf.followingVC.view];
        [weakSelf.joiningActivityVC setTableHeader:nil];
        [weakSelf.owningActivityVC setTableHeader:nil];
        [weakSelf.followingVC setTableHeader:weakCard];
    }];
    [self.card setJoiningActivityTouched:^{
        [weakSelf.view bringSubviewToFront:weakSelf.joiningActivityVC.view];
        [weakSelf.followingVC setTableHeader:nil];
        [weakSelf.owningActivityVC setTableHeader:nil];
        [weakSelf.joiningActivityVC setTableHeader:weakCard];
    }];
    
    [self.owningActivityVC setTableHeader:self.card];
}

- (void)requestUserInfo
{
    [self showLoading:@""];
    GetUserInfoParameter * p = (GetUserInfoParameter *)[ParameterFactory parameterWithApi:ApiGetUserInfo];
    p.userIdentifier = self.userId;
    p.uniqueId = self.description;
    [[CCNetworkManager defaultManager] requestWithParameter:p];
}

- (void)setFollowButtonHidden:(BOOL)hidden
{
    if (!self.followButton) {
        self.followButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.followButton setFrame:CGRectMake(0.f,
                                              self.view.height - kFollowButtonHeight,
                                              self.view.width,
                                               kFollowButtonHeight)];
        [self.followButton addTarget:self
                              action:@selector(followButtonTapped)
                    forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.followButton];
    }
    [self.followButton setHidden:hidden];
    
    if (hidden) {
        self.owningActivityVC.view.height =
        self.followButton.y + kFollowButtonHeight;
        self.joiningActivityVC.view.height =
        self.followButton.y + kFollowButtonHeight;
        self.followingVC.view.height =
        self.followButton.y + kFollowButtonHeight;
    }
    else {
        self.owningActivityVC.view.height =
        self.followButton.y;
        self.joiningActivityVC.view.height =
        self.followButton.y;
        self.followingVC.view.height =
        self.followButton.y;
    }
}

- (void)configFollowButton
{
    BOOL shouldHiddenFollowButton = [[UserModel currentUserId] isEqualToString:self.user.identifier] || [UserModel currentUser] == nil;
    [self setFollowButtonHidden:shouldHiddenFollowButton];
    if (shouldHiddenFollowButton) {
        return;
    }
    
    Relationship r = self.user.relationship;
    if ((r & RelationshipFollowing) == 0) {
        // 未关注
        [self.followButton setTitle:@"关注"
                           forState:UIControlStateNormal];
        [self.followButton setTitleColor:[UIColor colorWithRed:0.109 green:0.518 blue:0.892 alpha:1.000]
                                forState:UIControlStateNormal];
        [self.followButton setTag:kShouldFollowTag];
    }
    else {
        // 已关注
        [self.followButton setTitle:@"取消关注"
                           forState:UIControlStateNormal];
        [self.followButton setTitleColor:[UIColor colorWithRed:1.000 green:0.583 blue:0.636 alpha:1.000]
                                forState:UIControlStateNormal];
        [self.followButton setTag:kShouldUnfollowTag];
    }
}

#pragma mark - User Interaction
- (void)followButtonTapped
{
    [self showLoading:nil];
    if (self.followButton.tag == kShouldFollowTag) {
        // 关注
        FollowUserParameter * p = (FollowUserParameter *)[ParameterFactory parameterWithApi:ApiFollowUser];
        p.userIdentifier = self.user.identifier;
        p.uniqueId = self.description;
        [[CCNetworkManager defaultManager] requestWithParameter:p];
    }
    else if (self.followButton.tag == kShouldUnfollowTag) {
        // 取关
        UnfollowUserParameter * p = (UnfollowUserParameter *)[ParameterFactory parameterWithApi:ApiUnfollowUser];
        p.userIdentifier = self.user.identifier;
        p.uniqueId = self.description;
        [[CCNetworkManager defaultManager] requestWithParameter:p];
    }
    else {
        return;
    }
}
@end
