//
//  FollowerViewController.m
//  CarChat
//
//  Created by Develop on 15/1/15.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "FollowerViewController.h"
#import "UserModel.h"
#import "UsersCollectionDelegator.h"
#import "UserCell.h"
#import <UIImageView+WebCache.h>

static NSString * const followerCellIdentifier = @"followerCell";

@interface FollowerViewController ()
@property (nonatomic, copy) NSString * userId;
@property (weak, nonatomic) IBOutlet UITableView *followerTable;
@property (nonatomic, strong) NSMutableArray * followerUsers;
@property (nonatomic, strong) CollectionDelegator * followerDelegator;
@end

@implementation FollowerViewController
#pragma mark - Lifecycle
- (instancetype)initWithUserId:(NSString *)userId
{
    if (self = [super init]) {
        self.userId = userId;
        self.followerUsers = [NSMutableArray array];
        return self;
    }
    return nil;
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"关注我的";
    
    [self setupFollowerData];
    [self setupDelegator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Internal Helper
- (void)setupDelegator
{
    self.followerDelegator = [[UsersCollectionDelegator alloc]initWithItems:self.followerUsers andCellIdentifier:followerCellIdentifier];
    self.followerDelegator.cellClass = [UserCell class];
    [self.followerTable setDelegate:self.followerDelegator];
    [self.followerTable setDataSource:self.followerDelegator];
    
    [self.followerDelegator setConfigBlock:^(UserModel * user, UserCell * cell) {
        [cell.avatar sd_setImageWithURL:[NSURL URLWithString:user.avatar]];
        cell.name.text = user.nickName;
        cell.genderIcon.image = user.genderImage;
        [cell.certifyIcon sd_setImageWithURL:[NSURL URLWithString:user.avatar]];
    }];
    [self.followerDelegator setSelectingBlock:^(UserModel * user) {
        // TODO: 进入用户主页
    }];

}

- (void)setupFollowerData
{
    for (int i = 0; i < 10; i++) {
        UserModel *user = [[UserModel alloc]init];
        user.phone = @"13515125483";
        user.nickName = [NSString stringWithFormat:@"脑残僵尸NO.%d",i];
        user.age = @"3?";
        user.avatar = @"http://c.hiphotos.baidu.com/image/pic/item/b2de9c82d158ccbfdea2743c1ad8bc3eb135419e.jpg";
        user.gender = i%2 + 1;
        user.city = @"深圳";
        user.countOfActvity = [@(5*i) stringValue];
        user.countOfFollowing = @"两千四百万";
        user.countOfFollower = @"150";
        [self.followerUsers addObject:user];
    }
}

@end
