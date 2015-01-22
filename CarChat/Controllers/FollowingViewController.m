//
//  FollowingViewController.m
//  CarChat
//
//  Created by Develop on 15/1/15.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "FollowingViewController.h"
#import "UserModel.h"
#import "UserCell.h"
#import "UsersCollectionDelegator.h"
#import <UIImageView+WebCache.h>

static NSString * const followingCellIdentifier = @"followingCell";

@interface FollowingViewController ()

@property (nonatomic, copy) NSString * userId;
@property (weak, nonatomic) IBOutlet UITableView *followingTable;
@property (nonatomic, strong) NSMutableArray *followingUsers;
@property (nonatomic, strong) CollectionDelegator * followingDelegator;
@end

@implementation FollowingViewController

#pragma mark - Lifecycle
- (instancetype)initWithUserId:(NSString *)userId
{
    if (self = [super init]) {
        self.userId = userId;
        self.followingUsers = [NSMutableArray array];
        return self;
    }
    return nil;
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我关注的";
    [self setupFollowingData];
    [self setupDelegator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Internal Helper
- (void)setupDelegator
{
    self.followingDelegator = [[UsersCollectionDelegator alloc]initWithItems:self.followingUsers andCellIdentifier:followingCellIdentifier];
    self.followingDelegator.cellClass = [UserCell class];
    [self.followingTable setDelegate:self.followingDelegator];
    [self.followingTable setDataSource:self.followingDelegator];
    
    [self.followingDelegator setConfigBlock:^(UserModel * user, UserCell * cell) {
        [cell.avatar sd_setImageWithURL:[NSURL URLWithString:user.avatar]];
        cell.name.text = user.nickName;
        cell.genderIcon.image = user.genderImage;
        [cell.certifyIcon sd_setImageWithURL:[NSURL URLWithString:user.avatar]];
    }];
    __weak typeof(self) weakRef = self;
    [self.followingDelegator setSelectingBlock:^(UserModel * user) {
        [ControllerCoordinator goNextFrom:weakRef whitTag:MyFollowingCellTag andContext:user.identifier];
    }];
}

- (void)setupFollowingData
{
    for (int i = 0; i < 10; i++) {
        UserModel *user = [[UserModel alloc]init];
        user.phone = @"13515125483";
        user.nickName = [NSString stringWithFormat:@"嫖娼公知NO.%d",i];
        user.age = @"55?";
        user.avatar = @"http://g.hiphotos.baidu.com/image/pic/item/5366d0160924ab18713a223136fae6cd7b890b8c.jpg";
        user.gender = i%2 + 1;
        user.city = @"魔都";
        user.countOfActvity = [@(5*i) stringValue];
        user.countOfFollowing = @"5";
        user.countOfFollower = @"两千四百万";
        [self.followingUsers addObject:user];
    }
}

@end
