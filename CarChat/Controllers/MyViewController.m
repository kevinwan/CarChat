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

@interface MyViewController ()

@property (nonatomic, strong) UserModel *i;

@end

@implementation MyViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我";
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(slapMe)]];
    
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
    
    UserProfileCard * card = [UserProfileCard view];
    [card layoutWithUser:self.i];
    card.y += 64.f;
    [self.view addSubview:card];
    
    [card setActivityTouched:^{
        LOG_EXPR(@"activity:");
    }];
    [card setFollowingTouched:^{
        LOG_EXPR(@"following");
    }];
    [card setFollowerTouched:^{
        LOG_EXPR(@"follower");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)slapMe {
    [ControllerCoordinator goNextFrom:self whitTag:MyEditProfileTag andContext:self.i];
}

@end
