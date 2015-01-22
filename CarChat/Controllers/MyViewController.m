//
//  MyViewController.m
//  CarChat
//
//  Created by Develop on 15/1/15.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "MyViewController.h"
#import "UserModel.h"
#import "UserProfileCard.h"
#import "UIView+frame.h"
#import "UserActivitiesViewController.h"
#import "FollowingViewController.h"
#import "FollowerViewController.h"

@interface MyViewController ()

@property (nonatomic, strong) UserModel *i;
@property (nonatomic, strong) UserActivitiesViewController * activityVC;
@property (nonatomic, strong) FollowingViewController * followingVC;
@property (nonatomic, strong) FollowerViewController * followerVC;

@end

@implementation MyViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我";
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(slapMe)]];
    
    [self setupContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Interaction
- (void)slapMe {
    [ControllerCoordinator goNextFrom:self whitTag:MyEditProfileTag andContext:self.i];
}

#pragma mark - Internal Helper


- (void)setupContentView
{
    [self setupPersonalInfo];
    
    UserProfileCard * card = [UserProfileCard view];
    [card setFrame:CGRectMake(0.f, 64.f, card.width, card.height)];
    [card layoutWithUser:self.i];
    [self.view addSubview:card];
    
    self.activityVC = [[UserActivitiesViewController alloc]init];
    self.followingVC = [[FollowingViewController alloc]initWithUserId:self.i.identifier];
    self.followerVC = [[FollowerViewController alloc]initWithUserId:self.i.identifier];
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
    
    [card setActivityTouched:^{
        LOG_EXPR(@"activity vc");
        [self.view bringSubviewToFront:self.activityVC.view];
    }];
    [card setFollowingTouched:^{
        LOG_EXPR(@"following vc");
        [self.view bringSubviewToFront:self.followingVC.view];
    }];
    [card setFollowerTouched:^{
        LOG_EXPR(@"follower vc");
        [self.view bringSubviewToFront:self.followerVC.view];
    }];
}

- (void)setupPersonalInfo
{
    self.i = [[UserModel alloc]init];
    self.i.phone = @"13515125483";
    self.i.nickName = @"格格巫";
    self.i.age = @"28";
    self.i.avatar = @"http://b.hiphotos.baidu.com/image/pic/item/810a19d8bc3eb135eae45086a51ea8d3fd1f44e8.jpg";
    self.i.gender = GenderMale;
    self.i.city = @"南京";
    self.i.countOfActvity = @"20";
    self.i.countOfFollowing = @"5";
    self.i.countOfFollower = @"1000000000";
}
@end
