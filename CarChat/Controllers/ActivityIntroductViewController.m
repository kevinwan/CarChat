//
//  ActivityDetailViewController.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ActivityIntroductViewController.h"
#import "ActivityEditView.h"

@interface ActivityIntroductViewController ()

@property (nonatomic, strong) ActivityModel * activity;
@property (nonatomic, strong) ActivityModel * createdActivity;
@property (nonatomic, strong) ActivityEditView * editView;
@property (nonatomic, strong) UIBarButtonItem * leftItemStore;
@property (nonatomic, strong) UIBarButtonItem * rightItemStore;

@property (nonatomic, assign) BOOL showEditingAnimatedAfterLogin;

@end

@implementation ActivityIntroductViewController

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
    [[CCNetworkManager defaultManager] removeObserver:self
                                               forApi:ApiLogin];
    [[CCNetworkManager defaultManager] removeObserver:self
                                               forApi:ApiRegister];
    [[CCNetworkManager defaultManager] removeObserver:self
                                               forApi:ApiCreateActivity];
}

#pragma mark - View Liftcycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.activity.name;
    [self setRightNavigationBarItem:@"GO!"
                             target:self
                          andAction:@selector(createAndEditTheActivity)];
    
    self.editView = [ActivityEditView view];
    [self.editView layoutWithActivity:self.activity];
    [self.view addSubview:self.editView];
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self
                                            forApi:ApiLogin];
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self
                                            forApi:ApiRegister];
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self
                                            forApi:ApiCreateActivity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.showEditingAnimatedAfterLogin) {
        [self animateEditingView];
    }
}

#pragma mark - CCNetworkResponse
- (void)didGetResponseNotification:(ConcreteResponseObject *)response
{
    [self hideHud];
    
    if (response.error) {
        // failed
    }
    else {
        // successful
        NSString * api = response.api;
        if (api == ApiLogin || api == ApiRegister) {
            // 登录完成后，会改变活动的可编辑状态
            self.showEditingAnimatedAfterLogin = YES;
        }
        else if (api == ApiCreateActivity) {
            // 创建成功
            // TODO: 调用网络层解析好的activity对象
            self.createdActivity = [ActivityModel ActivityWithParameter:(CreateActivityParameter *)response.parameter];
            [self.editView layoutWithActivity:self.createdActivity];
            [self.editView setUserInteractionEnabled:NO];
            [self setLeftNavigationBarItem:@"关闭" target:self andAction:@selector(close) animated:YES];
            [self setRightNavigationBarItem:@"邀请" target:self andAction:@selector(invite) animated:YES];
        }
    }
}


#pragma mark - User Interaction
- (void)createAndEditTheActivity
{
    [ControllerCoordinator goNextFrom:self
                              whitTag:ShowLoginFromSomeWhereTag
                           andContext:nil];
}

- (void)create
{
    [self.editView endEditing:YES];
    [self.editView setUserInteractionEnabled:NO];
    
    NSData * imgData;
    ActivityModel * fromEditing = [self.editView generateActivityAndStoreImageData:&imgData];
    // 调用接口，创建活动
    CreateActivityParameter * parameter = [fromEditing parameter];
    
    [self showLoading:nil];
    [[CCNetworkManager defaultManager] requestWithParameter:parameter];
}

- (void)giveUp
{
    [self.navigationItem setLeftBarButtonItem:self.leftItemStore animated:YES];;
    [self.navigationItem setRightBarButtonItem:self.rightItemStore animated:YES];
    [self.editView endEditing:YES];
    [self.editView setUserInteractionEnabled:NO];
}

- (void)close
{
    [ControllerCoordinator goNextFrom:self
                              whitTag:CreatedActivityCloseButtonItemTag
                           andContext:nil];
}

- (void)invite
{
    [ControllerCoordinator goNextFrom:self
                              whitTag:CreatedActivityInviteButtonItemTag
                           andContext:self.createdActivity];
}

#pragma mark - Internal Helper
- (void)animateEditingView
{
    self.showEditingAnimatedAfterLogin = NO;
    
    [self.editView setUserInteractionEnabled:YES];
    [self.editView beginEdit];
    
    self.rightItemStore = self.navigationItem.rightBarButtonItem;
    [self setRightNavigationBarItem:@"创建" target:self andAction:@selector(create) animated:YES];
    [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
    
    self.leftItemStore = self.navigationItem.leftBarButtonItem;
    [self setLeftNavigationBarItem:@"取消" target:self andAction:@selector(giveUp) animated:YES];
}

@end
