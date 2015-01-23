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

@interface UserDetailViewController ()

@property (nonatomic, copy) NSString * userId;
@property (nonatomic, strong) UserModel * user;
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

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) wearkRef = self;
    [self showTip:@"loading..." whenDone:^{
        [wearkRef setupContentView];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Internal Helper
- (void)setupContentView
{
    [self setupPersonalInfo];
    
    UserProfileCard * card = [UserProfileCard view];
    [card layoutWithUser:self.user];
    [self.view addSubview:card];
    
    self.activityVC = [[UserActivitiesViewController alloc]init];
    self.followingVC = [[FollowingViewController alloc]initWithUserId:self.user.identifier];
    self.followerVC = [[FollowerViewController alloc]initWithUserId:self.user.identifier];
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
        LOG_EXPR(@"activity vc");
        [weakRef.view bringSubviewToFront:weakRef.activityVC.view];
    }];
    [card setFollowingTouched:^{
        LOG_EXPR(@"following vc");
        [weakRef.view bringSubviewToFront:weakRef.followingVC.view];
    }];
    [card setFollowerTouched:^{
        LOG_EXPR(@"follower vc");
        [weakRef.view bringSubviewToFront:weakRef.followerVC.view];
    }];
    [card setRelationshipTouched:^{
        // TODO: follow sb or unfollow sb
    }];
}

- (void)setupPersonalInfo
{
    self.user = [[UserModel alloc]init];
    self.user.phone = @"13515125483";
    self.user.nickName = @"格格巫";
    self.user.age = @"28";
    self.user.avatar = @"http://b.hiphotos.baidu.com/image/pic/item/810a19d8bc3eb135eae45086a51ea8d3fd1f44e8.jpg";
    self.user.gender = GenderMale;
    self.user.city = @"南京";
    self.user.countOfActvity = @"20";
    self.user.countOfFollowing = @"5";
    self.user.countOfFollower = @"1000000000";
}


@end
