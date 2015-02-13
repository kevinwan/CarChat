//
//  FollowingViewController.m
//  CarChat
//
//  Created by Develop on 15/1/15.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "FollowingViewController.h"
#import "UserModel.h"
#import "UserModel+helper.h"
#import "UserCell.h"
#import "UsersCollectionDelegator.h"
#import <UIImageView+WebCache.h>
#import "GetFollowingParameter.h"

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

- (void)dealloc
{
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiGetFollowing];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"关注";

    [self setupDelegator];
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiGetFollowing];
    
    [self requestFollowing];
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
        [self.followingUsers addObjectsFromArray:response.object];
        [self.followingTable reloadData];
    }
}

#pragma mark - Internal Helper
- (void)setupDelegator
{
    self.followingDelegator = [[UsersCollectionDelegator alloc]initWithItems:self.followingUsers andCellIdentifier:followingCellIdentifier];
    self.followingDelegator.cellClass = [UserCell class];
    [self.followingTable setDelegate:self.followingDelegator];
    [self.followingTable setDataSource:self.followingDelegator];
    
    [self.followingDelegator setConfigBlock:^(UserModel * user, UserCell * cell) {
        [cell.avatar sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl]];
        cell.name.text = user.nickName;
        cell.genderIcon.image = user.genderImage;
        [cell.certifyIcon sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl]];
    }];
    __weak typeof(self) weakRef = self;
    [self.followingDelegator setSelectingBlock:^(UserModel * user) {
        [ControllerCoordinator goNextFrom:weakRef whitTag:MyFollowingCellTag andContext:user.identifier];
    }];
}

- (void)requestFollowing
{
    [self showLoading:@""];
    
    GetFollowingParameter * p = (GetFollowingParameter *)[ParameterFactory parameterWithApi:ApiGetFollowing];
    p.userIdentifier = self.userId;
    p.uniqueId = self.description;
    [[CCNetworkManager defaultManager] requestWithParameter:p];
}


#pragma mark - Public APIs
- (void)setTableHeader:(UIView *)header
{
    [self.followingTable setTableHeaderView:header];
}

@end
