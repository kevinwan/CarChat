//
//  EditActivityViewController.m
//  CarChat
//
//  Created by Jia Zhao on 2/8/15.
//  Copyright (c) 2015 GongPingJia. All rights reserved.
//

#import "EditActivityViewController.h"
#import "ActivityEditView.h"
#import <UzysAssetsPickerController.h>
#import "UIView+frame.h"
#import "UserModel+helper.h"
#import "CreateActivityParameter.h"
#import "ActivityModel+Helper.h"
#import "ActivityInvitator.h"

@interface EditActivityViewController ()

@property (nonatomic, strong) UIButton * saveAndInviteButton;

@property (nonatomic, strong) ActivityModel * activity;

@property (nonatomic, strong) ALAsset * asset;

@property (nonatomic, strong) ActivityInvitator * invitator;

@end

@implementation EditActivityViewController

#pragma mark - Lifecycle
- (instancetype)initWithActivity:(ActivityModel *)activity
{
    if (self = [super init]) {
        self.activity = activity;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can .ble recreated.
}

- (void)dealloc
{
    [self.view removeObserver:self
                   forKeyPath:@"isAllFieldFilled"];
    [[CCNetworkManager defaultManager] removeObserver:self
                                               forApi:ApiCreateActivity];
}

#pragma mark - View Lifycycle

- (void)loadView
{
    ActivityEditView * v = [ActivityEditView view];
    if (_activity) {
        [v layoutWithActivity:_activity];
    }
    __weak typeof(self) _weakRef = self;
    [v setChoosePosterBlock:^ UIImage *{
        UzysAssetsPickerController * imagePicker = [[UzysAssetsPickerController alloc]init];
        imagePicker.assetsFilter = [ALAssetsFilter allPhotos];
        imagePicker.delegate = (id<UzysAssetsPickerControllerDelegate>)_weakRef;
        imagePicker.maximumNumberOfSelectionPhoto = 1;
        imagePicker.maximumNumberOfSelectionVideo = 0;
        [_weakRef presentViewController:imagePicker
                               animated:YES
                             completion:nil];
        CFRunLoopRun();
        return [UIImage imageWithCGImage: _weakRef.asset.aspectRatioThumbnail];
    }];
    self.view = v;
    
    [v addObserver:self
        forKeyPath:@"isAllFieldFilled"
           options:NSKeyValueObservingOptionNew
           context:nil];
    
    _saveAndInviteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_saveAndInviteButton setFrame:
     CGRectMake(0.f,
                self.view.frame.size.height - 40.f,
                self.view.frame.size.width,
                40.f)];
    [_saveAndInviteButton setTitle:@"保存并邀请"
                   forState:UIControlStateNormal];
    [_saveAndInviteButton addTarget:self
                      action:@selector(checkIfLoginThenSave)
            forControlEvents:UIControlEventTouchUpInside];
    [_saveAndInviteButton setEnabled:[v isAllFieldFilled].boolValue];
    [self.view addSubview:_saveAndInviteButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.activity != nil) {
        self.navigationItem.title = @"创建活动";
    }
    else {
        self.navigationItem.title = @"编辑活动";
    }
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self
                                            forApi:ApiCreateActivity];
}

#pragma mark - CCNetworkResponse
- (void)didGetResponseNotification:(ConcreteResponseObject *)response
{
    [self hideHud];
    if (response.error) {
        [self showTip:response.error.localizedDescription];
    }
    else {
        [self.view setUserInteractionEnabled:NO];
        [_saveAndInviteButton setEnabled:NO];
        ActivityModel * m = response.object;
        [self sendInvitationWithActivity:m];
    }
}

#pragma mark - Observation
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    BOOL buttonEnable = [change[@"new"] boolValue];
    [self.saveAndInviteButton setEnabled:buttonEnable];
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
- (void)checkIfLoginThenSave
{
    if ([UserModel currentUser]) {
        // 已经登录，发送创建和邀请请求
        [self saveAndInvite];
    }
    else {
        // 未登录，登录之
        [ControllerCoordinator goNextFrom:self
                                  whitTag:ShowLoginFromSomeWhereTag
                               andContext:nil];
    }
}

- (void)saveAndInvite
{
    [self showLoading:@"正在创建"];
    CreateActivityParameter * parameter = [[(ActivityEditView *)self.view generateActivity] parameter];
    [[CCNetworkManager defaultManager] requestWithParameter:parameter];
}

- (void)sendInvitationWithActivity:(ActivityModel *)activity
{
    self.invitator = [[ActivityInvitator alloc]initWithActivity:activity onViewController:self];
    [self.invitator show];
}

@end
