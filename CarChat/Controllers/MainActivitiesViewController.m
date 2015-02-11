//
//  MainActivitiesViewController.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "MainActivitiesViewController.h"
#import "ActivitiesCollectionDelegator.h"
#import "ActivityModel.h"
#import <UIImageView+WebCache.h>
#import "GetSuggestActivitiesParameter.h"
#import "EditActivityViewController.h"

static NSString * const activityCellIdentifier = @"activityCellIdentifier";

@interface MainActivitiesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *suggestionTableView;
@property (nonatomic, strong) NSMutableArray * activities;
@property (nonatomic, strong) ActivitiesCollectionDelegator * tableDelegator;

@end

@implementation MainActivitiesViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"活动";
    [self setRightNavigationBarItem:@"创建" target:self andAction:@selector(gotoCreate)];
    
    [self setupDelegator];
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self
                                            forApi:ApiGetSuggestActivities];
    
    [self requestSuggestActivities];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lifecycle
- (instancetype)init
{
    if (self = [super init]) {
        self.activities = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc
{
    [[CCNetworkManager defaultManager] removeObserver:self
                                               forApi:ApiGetSuggestActivities];
}

#pragma mark - CCNetworkResponse
- (void)didGetResponseNotification:(ConcreteResponseObject *)response
{
    [self hideHud];
    if (response.error) {
        // failed
        [self showTip:response.error.localizedDescription];
    }
    else {
        // success
        NSString * api = response.api;
        if (api == ApiGetSuggestActivities) {
            [self.activities addObjectsFromArray:(NSArray *)response.object];
            [self.suggestionTableView reloadData];
        }
    }
}

#pragma mark - User Interaction
- (void)gotoCreate
{
    [ControllerCoordinator goNextFrom:self
                              whitTag:kFromMainActivitiesVCCreateButtonTag
                           andContext:nil];
}

#pragma mark - Internal Helper
- (void)setupDelegator
{
    self.tableDelegator = [[ActivitiesCollectionDelegator alloc]initWithItems:self.activities
                                                            andCellIdentifier:activityCellIdentifier];
    self.tableDelegator.cellClass = [ActivityCell class];
//    self.tableDelegator.style = ActivityCellStyleSuggest;
    [self.tableDelegator setConfigBlock:
     ^(ActivityModel * activity, ActivityCell * cell) {
         [cell.poster sd_setImageWithURL:[NSURL URLWithString:activity.posterUrl]];
         cell.name.text = activity.name;
         [cell.ownerAvatar sd_setImageWithURL:[NSURL URLWithString:activity.owner.avatarUrl]];
         [cell.period setText:[NSString stringWithFormat:@"活动时间: %@ - %@", activity.fromDate, activity.toDate]];
         [cell.createdDate setText:activity.createDate];
     }];
    __weak typeof(self) weakRef = self;
    [self.tableDelegator setSelectingBlock:
     ^(ActivityModel * activity) {
         __strong typeof(self) strongRef = weakRef;
         [ControllerCoordinator goNextFrom:strongRef
                                   whitTag:SuggestActivitiesSelectItem
                                andContext:activity];
     }];
    [self.suggestionTableView setDataSource:self.tableDelegator];
    [self.suggestionTableView setDelegate:self.tableDelegator];
}

- (void)requestSuggestActivities
{
    [self showLoading:@""];
    GetSuggestActivitiesParameter * par = (GetSuggestActivitiesParameter *)[ParameterFactory parameterWithApi:ApiGetSuggestActivities];
    [[CCNetworkManager defaultManager] requestWithParameter:par];
}

@end
