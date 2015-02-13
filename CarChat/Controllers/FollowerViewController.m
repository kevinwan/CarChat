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
#import "UserModel+helper.h"
#import <UIImageView+WebCache.h>
#import "GetFollowersParameter.h"

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
    }
    return self;
}

- (void)dealloc
{
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiGetFollowers];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"听众";

    [self setupDelegator];
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiGetFollowers];
    
    [self requestFollowers];
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
        [self showTip:response.error.localizedDescription];
    }
    else {
        [self.followerUsers addObjectsFromArray:response.object];
        [self.followerTable reloadData];
    }
}

#pragma mark - Internal Helper
- (void)setupDelegator
{
    self.followerDelegator = [[UsersCollectionDelegator alloc]initWithItems:self.followerUsers andCellIdentifier:followerCellIdentifier];
    self.followerDelegator.cellClass = [UserCell class];
    [self.followerTable setDelegate:self.followerDelegator];
    [self.followerTable setDataSource:self.followerDelegator];
    
    [self.followerDelegator setConfigBlock:^(UserModel * user, UserCell * cell) {
        [cell.avatar sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl]];
        cell.name.text = user.nickName;
        cell.genderIcon.image = user.genderImage;
        [cell.certifyIcon setImage:user.certifyStatusImage];
    }];
    __weak typeof(self) weakRef = self;
    [self.followerDelegator setSelectingBlock:^(UserModel * user) {
        [ControllerCoordinator goNextFrom:weakRef whitTag:MyFollowerCellTag andContext:user.identifier];
    }];

}

- (void)requestFollowers
{
    [self showLoading:@""];
    
    GetFollowersParameter * p = (GetFollowersParameter *)[ParameterFactory parameterWithApi:ApiGetFollowers];
    p.userIdentifier = self.userId;
    p.uniqueId = self.description;
    [[CCNetworkManager defaultManager] requestWithParameter:p];
}

@end
