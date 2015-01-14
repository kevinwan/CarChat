//
//  ActivityDetailViewController.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ActivityIntroductViewController.h"
#import "ActivityIntrudoctionView.h"
#import "ActivityEditView.h"

@interface ActivityIntroductViewController ()

@property (nonatomic, strong) ActivityModel * activity;
@property (nonatomic, strong) ActivityIntrudoctionView * introductView;
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
}

#pragma mark - View Liftcycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setRightNavigationBarItem:@"GO!"
                             target:self
                          andAction:@selector(createAndEditTheActivity)];
    
    self.introductView = [ActivityIntrudoctionView view];
    [self.introductView layoutWithActivity:self.activity];
    [self.view addSubview:self.introductView];
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self
                                            forApi:ApiLogin];
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
// 登录完成后，会改变活动的可编辑状态
- (void)didGetResponseNotification:(ConcreteResponseObject *)response
{
    if (response.error) {
        // failed
    }
    else {
        // successful
        self.showEditingAnimatedAfterLogin = YES;
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
    NSData * imgData;
    ActivityModel * fromEditing = [self.editView generateActivityAndStoreImageData:&imgData];
    // 调用接口，创建活动
}

- (void)giveUp
{
    [UIView animateWithDuration:.3f animations:^{
        self.navigationItem.leftBarButtonItem = self.leftItemStore;
        self.navigationItem.rightBarButtonItem = self.rightItemStore;
        [self.editView setHidden:NO];
        [self.introductView setHidden:YES];
    }];
}

#pragma mark - Internal Helper
- (void)animateEditingView
{
    self.editView = [ActivityEditView viewWithActivity:self.activity];
    [self.editView setHidden:YES];
    [self.view addSubview:self.editView];
    
    [UIView animateWithDuration:.3f animations:^{
        self.rightItemStore = self.navigationItem.rightBarButtonItem;
        [self setRightNavigationBarItem:@"创建" target:self andAction:@selector(create)];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
        
        self.leftItemStore = self.navigationItem.leftBarButtonItem;
        [self setLeftNavigationBarItem:@"取消" target:self andAction:@selector(giveUp)];
        
        [self.introductView setHidden:YES];
        [self.editView setHidden:NO];
    }];
}

@end
