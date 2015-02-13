//
//  ParicipantsViewController.m
//  CarChat
//
//  Created by Jia Zhao on 2/12/15.
//  Copyright (c) 2015 GongPingJia. All rights reserved.
//

#import "ParticipantsViewController.h"
#import "UserModel.h"
#import "UsersCollectionDelegator.h"
#import "UserCell.h"
#import "UserModel+helper.h"
#import <UIImageView+WebCache.h>
#import "GetParticipantsParameter.h"

static NSString * const kParticipantCellIdentifier = @"participantCell";


@interface ParticipantsViewController ()
@property (nonatomic, copy) NSString * activityid;
@property (weak, nonatomic) IBOutlet UITableView *paticipantsTable;
@property (nonatomic, strong) NSMutableArray * participants;
@property (nonatomic, strong) CollectionDelegator * participantsTableDelegate;

@end

@implementation ParticipantsViewController

#pragma mark - Lifecycle
- (instancetype)initWithAvtivityId:(NSString *)activityId
{
    if (self = [super init]) {
        self.activityid = activityId;
        self.participants = [NSMutableArray array];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiGetParticipants];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"参与人";
    
    [self setupDelegator];
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiGetParticipants];
    
    [self requestParticipants];
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
        [self.participants addObjectsFromArray:response.object];
        [self.paticipantsTable reloadData];
    }
}

#pragma mark - Internal Helper
- (void)setupDelegator
{
    self.participantsTableDelegate = [[UsersCollectionDelegator alloc]initWithItems:self.participants andCellIdentifier:kParticipantCellIdentifier];
    self.participantsTableDelegate.cellClass = [UserCell class];
    [self.paticipantsTable setDelegate:self.participantsTableDelegate];
    [self.paticipantsTable setDataSource:self.participantsTableDelegate];
    
    [self.participantsTableDelegate setConfigBlock:^(UserModel * user, UserCell * cell) {
        [cell.avatar sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl]];
        cell.name.text = user.nickName;
        cell.genderIcon.image = user.genderImage;
        [cell.certifyIcon setImage:user.certifyStatusImage];
    }];
    __weak typeof(self) weakRef = self;
    [self.participantsTableDelegate setSelectingBlock:^(UserModel * user) {
        [ControllerCoordinator goNextFrom:weakRef whitTag:kParticipantsCellTag andContext:user.identifier];
    }];
}

- (void)requestParticipants
{
    [self showLoading:nil];
    GetParticipantsParameter * p = (GetParticipantsParameter *)[ParameterFactory parameterWithApi:ApiGetParticipants];
    p.activityIdentifier = self.activityid;
    p.uniqueId = self.description;
    [[CCNetworkManager defaultManager] requestWithParameter:p];
}

@end
