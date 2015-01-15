//
//  InviteViewController.m
//  CarChat
//
//  Created by 赵佳 on 15/1/15.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "InviteViewController.h"
#import "CreateInviteCodeParameter.h"
#import "InviteTableDelegator.h"

static NSString * const cellIdentifier = @"inviteCell";
static NSString * const InviteItemWXTimeLine = @"微信朋友圈";
static NSString * const InviteItemWXChat = @"微信好友";
static NSString * const InviteItemSMS = @"短信";
static NSString * const InviteItemEMAIL = @"邮件";

@interface InviteViewController ()

@property (nonatomic, strong) ActivityModel *activity;
@property (nonatomic, strong) NSString * inviteCode;
@property (weak, nonatomic) IBOutlet UITableView *inviteTableView;
@property (nonatomic, strong) InviteTableDelegator * inviteTableDelegator;
@property (nonatomic, strong) NSArray * inviteItems;

@end

@implementation InviteViewController

#pragma mark - Lifecycle
- (instancetype)initWithActivity:(ActivityModel *)activity
{
    if (self = [super init]) {
        self.activity = activity;
    }
    return self;
}

- (void)dealloc
{
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiCreateInviteCode];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"邀请好友";
    [self setLeftNavigationBarItem:@"关闭"
                            target:self
                         andAction:@selector(close)];
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiCreateInviteCode];
    
    
    self.inviteItems = @[InviteItemWXTimeLine, InviteItemWXChat, InviteItemSMS, InviteItemEMAIL];
    self.inviteTableDelegator = [[InviteTableDelegator alloc]initWithItems:self.inviteItems cellIdentifier:cellIdentifier];
    [self.inviteTableDelegator setConfigBlock: ^(NSString * item, UITableViewCell * cell) {
        cell.textLabel.text = item;
    }];
    __weak typeof(self) weakref = self;
    [self.inviteTableDelegator setSelectingBlock: ^(NSString * item) {
        if (item == InviteItemWXTimeLine) {
            [weakref inviteViaWXTimeLine];
        }
        else if (item == InviteItemWXChat) {
            [weakref inviteViaWXChat];
        }
        else if (item == InviteItemSMS) {
            [weakref inviteViaSMS];
        }
        else {
            [weakref iniviteViaEmail];
        }
    }];
    [self.inviteTableView setDelegate:(id<UITableViewDelegate>)self.inviteTableDelegator];
    [self.inviteTableView setDataSource:(id<UITableViewDataSource>)self.inviteTableDelegator];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self showLoading:nil];
    CreateInviteCodeParameter * parameter = (CreateInviteCodeParameter *)[ParameterFactory parameterWithApi:ApiCreateInviteCode];
    parameter.activityIdentifier = self.activity.ID;
    [[CCNetworkManager defaultManager] requestWithParameter:parameter];
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
        // failed
    }
    else {
        // successed
        self.inviteCode = response.object;
    }
}

#pragma mark - User Interaction
- (void)close
{
    [ControllerCoordinator goNextFrom:self
                              whitTag:InviteCloseButtonItemTag
                           andContext:nil];
}

#pragma mark - Internal Helper
- (void)inviteViaWXTimeLine
{
    
}

- (void)inviteViaWXChat
{
    
}

- (void)inviteViaSMS
{
    
}

- (void)iniviteViaEmail
{
    
}

@end
