//
//  ActivityDetailViewController.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ActivityIntroductViewController.h"
#import "ActivityEditView.h"
#import "CCStatusManager.h"
#import <UzysAssetsPickerController.h>
#import "NSString+Helpers.h"

@interface ActivityIntroductViewController ()

@property (nonatomic, strong) ActivityModel * activity;
@property (nonatomic, strong) ActivityModel * createdActivity;
@property (nonatomic, strong) ActivityEditView * editView;
@property (nonatomic, strong) UIBarButtonItem * leftItemStore;
@property (nonatomic, strong) UIBarButtonItem * rightItemStore;

@property (nonatomic, strong) ALAsset * asset;

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
    
    [self setupEditView];
    
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
        [self showTip:response.error.localizedDescription];
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
            [self showTip:@"创建成功"];
//            // TODO: 把创建成功返回的id，赋值给createdActivity
//            self.createdActivity = [ActivityModel ActivityWithParameter:(CreateActivityParameter *)response.parameter];
//            [self.editView layoutWithActivity:self.createdActivity];
            [self.editView setUserInteractionEnabled:NO];
            [self setLeftNavigationBarItem:@"关闭" target:self andAction:@selector(close) animated:YES];
            [self setRightNavigationBarItem:@"邀请" target:self andAction:@selector(invite) animated:YES];
        }
    }
}

#pragma mark - UzysAssetsPickerControllerDelegate
- (void)UzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    LOG_EXPR(assets);
    self.asset = assets[0];
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)UzysAssetsPickerControllerDidCancel:(UzysAssetsPickerController *)picker
{
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)UzysAssetsPickerControllerDidExceedMaximumNumberOfSelection:(UzysAssetsPickerController *)picker
{
    return;
}

#pragma mark - User Interaction
- (void)createAndEditTheActivity
{
    if ([CCStatusManager isLoged]) {
        [self animateEditingView];
    }
    else {
        [ControllerCoordinator goNextFrom:self
                                  whitTag:ShowLoginFromSomeWhereTag
                               andContext:nil];
    }
}

- (void)create
{
    if (![self isAllFieldTexted]) {
        [self showTip:@"请完善活动信息"];
        return;
    }
    
    [self.editView endEditing:YES];
    [self.editView setUserInteractionEnabled:NO];
    
    // 调用接口，创建活动
    CreateActivityParameter * parameter = [[self.editView generateActivity] parameter];
    
    [self showLoading:@"正在创建"];
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
- (void)setupEditView
{
    self.editView = [ActivityEditView view];
    [self.editView layoutWithActivity:self.activity];
    __weak typeof(self) _weakRef = self;
    [self.editView setChoosePosterBlock:^ UIImage *{
        UzysAssetsPickerController * imagePicker = [[UzysAssetsPickerController alloc]init];
        imagePicker.assetsFilter = [ALAssetsFilter allPhotos];
        imagePicker.delegate = (id<UzysAssetsPickerControllerDelegate>)_weakRef;
        imagePicker.maximumNumberOfSelectionPhoto = 1;
        imagePicker.maximumNumberOfSelectionVideo = 0;
        [_weakRef presentViewController:imagePicker animated:YES completion:nil];
        CFRunLoopRun();
        return [UIImage imageWithCGImage: _weakRef.asset.defaultRepresentation.fullResolutionImage];
    }];
    [self.view addSubview:self.editView];
}

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

- (BOOL)isAllFieldTexted
{
    return
    ![self.editView.name.text isBlank] &&
    ![self.editView.date.text isBlank] &&
    ![self.editView.destiny.text isBlank] &&
    ![self.editView.toplimit.text isBlank] &&
    (self.editView.payType.selectedSegmentIndex == 2 || // 付费类型是土豪请客
     (self.editView.payType.selectedSegmentIndex != 2 && ![self.editView.cost.text isBlank]));  // 付费类型不是土豪请客，并且填写了每人承担费用
    
}

@end
