//
//  MyViewController.m
//  CarChat
//
//  Created by Develop on 15/1/15.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "MyViewController.h"
#import "UserModel.h"
#import "UIView+frame.h"
#import "UserProfileCard.h"
#import "CCStatusManager.h"
#import "UserModel+helper.h"
#import "GetUserInfoParameter.h"
#import <SVPullToRefresh.h>

@interface MyViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UserProfileCard * profileCard;
@property (nonatomic, strong) UITableView * functionTable;

@end

@implementation MyViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我";
    
    [self setLeftNavigationBarItem:@"设置" target:self andAction:@selector(setting)];
//    [self setRightNavigationBarItem:@"拍照" target:self andAction:@selector(takePhoto)];
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiGetUserInfo];
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiLogin];
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiSetPersonalInfo];
    [self refreshCurrentUserInfo];
}

#pragma mark - Lifecycle
- (void)dealloc
{
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiGetUserInfo];
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiLogin];
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiSetPersonalInfo];
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
    [self.functionTable.pullToRefreshView stopAnimating];
    if (response.error) {
        [self showTip:response.error.localizedDescription];
    }
    else {
        if (response.parameter.api == ApiGetUserInfo) {
            [self setupContentView];
        }
        else {
            // 在登陆或更新用户信息后，刷新页面
            [self refreshCurrentUserInfo];
        }
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"MyCellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"设置资料";
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"车主认证";
    }
//    else if (indexPath.row == 2) {
//        cell.textLabel.text = @"相册管理";
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [ControllerCoordinator goNextFrom:self whitTag:MyEditProfileTag andContext:[UserModel currentUser]];
    }
    else if (indexPath.row == 1) {
        LOG_EXPR(@"车主认证");
    }
//    else if (indexPath.row == 2) {
//        LOG_EXPR(@"相册管理");
//    }
}

#pragma mark - User Interaction
- (void)setting
{
    [ControllerCoordinator goNextFrom:self whitTag:kMySettingButtonTag andContext:nil];
}

- (void)takePhoto
{
    
}

#pragma mark - Internal Helper
- (void)refreshCurrentUserInfo
{
    [self showLoading:nil];
    GetUserInfoParameter * p = (GetUserInfoParameter *)[ParameterFactory parameterWithApi:ApiGetUserInfo];
    p.userIdentifier = [UserModel currentUserId];
    p.uniqueId = self.description;
    [[CCNetworkManager defaultManager] requestWithParameter:p];
}

-(void)setupContentView
{
    __weak typeof(self) weakSelf = self;
    
    if (!self.profileCard) {
        self.profileCard = [UserProfileCard view];
        [self.view addSubview:self.profileCard];
        
        [self.profileCard setOwningActivityTouched:^{
            [weakSelf showOwning];
        }];
        
        [self.profileCard setJoiningActivityTouched:^{
            [weakSelf showJoining];
        }];
        
        [self.profileCard setFollowingTouched:^{
            [weakSelf showFollowing];
        }];
    }
    
    [self.profileCard layoutWithUser:[UserModel currentUser]];
    
    if (!self.functionTable) {
        CGRect restFrame = self.view.bounds;
        self.functionTable = [[UITableView alloc]initWithFrame:restFrame style:UITableViewStylePlain];
        [self.functionTable setDelegate:self];
        [self.functionTable setDataSource:self];
        [self.functionTable setTableHeaderView:self.profileCard];
        [self.functionTable setTableFooterView:[UIView new]];
        [self.view addSubview:self.functionTable];
        
        [self.functionTable setShowsPullToRefresh:YES];
        [self.functionTable addPullToRefreshWithActionHandler:^{
            [weakSelf refreshCurrentUserInfo];
        }];
    }
    
    [self.functionTable reloadData];
}

- (void)showOwning
{
    [ControllerCoordinator goNextFrom:self whitTag:kMyOwningActivityButtonTag andContext:[UserModel currentUserId]];
}

- (void)showJoining
{
    [ControllerCoordinator goNextFrom:self whitTag:kMyJoiningActivityButtonTag andContext:[UserModel currentUserId]];
}

- (void)showFollowing
{
    [ControllerCoordinator goNextFrom:self whitTag:kMyFollowingButtonTag andContext:[UserModel currentUserId]];
}

@end
