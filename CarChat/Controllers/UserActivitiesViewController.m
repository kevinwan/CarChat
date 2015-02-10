//
//  MyActivitiesViewController.m
//  CarChat
//
//  Created by Develop on 15/1/15.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UserActivitiesViewController.h"
#import "ActivitiesCollectionDelegator.h"
#import "ActivityCell.h"
#import "ActivityModel.h"
#import <UIImageView+WebCache.h>
#import "GetUserJoiningActivitiesParameter.h"
#import "UserModel+helper.h"

static NSString * const activityCeleIdentifier = @"myActivityIdentifier";

@interface UserActivitiesViewController ()
@property (nonatomic, copy) NSString * userId;
@property (weak, nonatomic) IBOutlet UITableView *activityTable;
@property (nonatomic, strong) ActivitiesCollectionDelegator * tableDelegator;
@property (nonatomic, strong) NSMutableArray * activityItems;

@end

@implementation UserActivitiesViewController

#pragma mark - Lifecycle
- (instancetype)initWithUserId:(NSString *)userId
{
    if (self = [super init]) {
        self.userId = userId;
        self.activityItems = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc
{
    [[CCNetworkManager defaultManager] removeObserver:self
                                               forApi:ApiGetUserJoiningActivities];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableViewDelegator];
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self
                                            forApi:ApiGetUserJoiningActivities];
    
    [self requestActivities];
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
        [self showTip:response.error.localizedDescription];
    }
    else {
        [self.activityItems addObjectsFromArray:response.object];
        [self.activityTable reloadData];
    }
}

#pragma mark - Internal Helper
- (void)setupTableViewDelegator
{
    self.tableDelegator = [[ActivitiesCollectionDelegator alloc]initWithItems:self.activityItems andCellIdentifier:activityCeleIdentifier];
    [self.tableDelegator setCellClass:[ActivityCell class]];
    [self.tableDelegator setStyle:ActivityCellStyleUserCreated];
    [self.tableDelegator setConfigBlock:^(ActivityModel * activity, ActivityCell * cell) {
        [cell.poster sd_setImageWithURL:[NSURL URLWithString:activity.posterUrl]];
        cell.name.text = activity.name;
        [cell.ownerAvatar sd_setImageWithURL:[NSURL URLWithString:activity.owner.avatarUrl]];
        [cell.period setText:[NSString stringWithFormat:@"活动时间: %@ - %@", activity.fromDate, activity.toDate]];
        [cell.createdDate setText:activity.createDate];
    }];
    __weak typeof(self) weakRef = self;
    [self.tableDelegator setSelectingBlock:^(ActivityModel *activity) {
        [ControllerCoordinator goNextFrom:weakRef whitTag:MyActivityCellTag andContext:activity];
    }];
    
    [self.activityTable setDelegate:self.tableDelegator];
    [self.activityTable setDataSource:self.tableDelegator];
}

- (void)requestActivities
{
    [self showLoading:@""];
    GetUserJoiningActivitiesParameter * p = (GetUserJoiningActivitiesParameter *)[ParameterFactory parameterWithApi:ApiGetUserJoiningActivities];
    [p setUserIdentifier:self.userId];
    [[CCNetworkManager defaultManager] requestWithParameter:p];
}

@end
