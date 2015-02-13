//
//  MyActivitiesViewController.m
//  CarChat
//
//  Created by Develop on 15/1/15.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UserOwningActivitiesViewController.h"
#import "ActivitiesCollectionDelegator.h"
#import "ActivityCell.h"
#import "ActivityModel.h"
#import <UIImageView+WebCache.h>
#import "GetUserOwningActivitiesParameter.h"
#import "UserModel+helper.h"

static NSString * const activityCeleIdentifier = @"myActivityIdentifier";

@interface UserOwningActivitiesViewController ()
@property (nonatomic, copy) NSString * userId;
@property (weak, nonatomic) IBOutlet UITableView *activityTable;
@property (nonatomic, strong) ActivitiesCollectionDelegator * tableDelegator;
@property (nonatomic, strong) NSMutableArray * activityItems;

@end

@implementation UserOwningActivitiesViewController

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
                                               forApi:ApiGetUserOwningActivities];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"活动";

    [self setupTableViewDelegator];
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self
                                            forApi:ApiGetUserOwningActivities];
    
    [self requestActivities];
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
    GetUserOwningActivitiesParameter * p = (GetUserOwningActivitiesParameter *)[ParameterFactory parameterWithApi:ApiGetUserOwningActivities];
    [p setUserIdentifier:self.userId];
    [p setUniqueId:self.description];
    [[CCNetworkManager defaultManager] requestWithParameter:p];
}

#pragma mark - Public APIs
- (void)setTableHeader:(UIView *)header
{
    [self.activityTable setTableHeaderView:header];
}

@end
