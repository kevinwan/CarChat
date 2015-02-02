//
//  CompletePersonInfoViewController.m
//  CarChat
//
//  Created by Develop on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "CompletePersonalInfoViewController.h"
#import <UzysAssetsPickerController.h>
#import "PersonalInfoView.h"
#import "GetActivityWithInviteCodeParameter.h"
#import "NSString+Helpers.h"
#import "CCStatusManager.h"
#import <UIButton+WebCache.h>
#import "SetPersonalInfoParameter.h"

@interface CompletePersonalInfoViewController ()

@property (nonatomic, copy) NSString * userId;
@property (nonatomic, strong) PersonalInfoView * contentView;
@property (nonatomic, strong) ALAsset * asset;

@end

@implementation CompletePersonalInfoViewController
#pragma mark - Lifecycle
- (instancetype)initWithUserId:(NSString *)userId
{
    if (self = [super init]) {
        self.userId = userId;
    }
    return self;
}

- (void)dealloc
{
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiSetPersonalInfo];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    /*Navigation item custom*/
    self.navigationItem.title = @"个人信息";
    [self.navigationItem setHidesBackButton:YES animated:NO];
    [self setRightNavigationBarItem:@"完成"
                             target:self
                          andAction:@selector(completeInfoDone)];
    [self.navigationItem.rightBarButtonItem setEnabled:NO]; // default is disable
    
    /*Load content view*/
    [self setupContentView];
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiSetPersonalInfo];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(updateDoneButton)
                                                name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CCNetworkResponse
- (void)didGetResponseNotification:(ConcreteResponseObject *)response
{
    [self hideHud];
    NSError * error = response.error;
    if (error) {
        // 失败
        [self showTip:error.localizedDescription];
        return;
    }
    else {
        // 成功
        GetActivityWithInviteCodeParameter * parameter = (GetActivityWithInviteCodeParameter *)[ParameterFactory parameterWithApi:ApiGetActivityWithInviteCode];
        parameter.inviteCode = [CCStatusManager defaultManager].verifyedInviteCode;
        [[CCNetworkManager defaultManager] requestWithParameter:parameter];
        [self dismissSelf];
    }
}

#pragma mark - UITextFieldNotify
- (void)updateDoneButton
{
    [self.navigationItem.rightBarButtonItem setEnabled:[self allFieldsTexted]];
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
- (void)completeInfoDone
{
    [self showLoading:@"正在保存..."];
    SetPersonalInfoParameter * par = (SetPersonalInfoParameter *)[ParameterFactory parameterWithApi:ApiSetPersonalInfo];
    par.nickName = self.contentView.nickNameField.text;
    par.age = self.contentView.ageField.text;
    par.city = self.contentView.cityField.text;
    par.gender = self.contentView.genderControl.selectedSegmentIndex + 1;
    par.avatar = UIImageJPEGRepresentation(self.contentView.avatarButton.currentBackgroundImage, .1);
    [[CCNetworkManager defaultManager] requestWithParameter:par];
}

#pragma mark - Internal Helper
- (void)setupContentView
{
    self.contentView = [PersonalInfoView viewWithStyle:PersonalInfoViewStyleNormal];
    [self.contentView setFrame:self.view.bounds];
    [self.view addSubview:self.contentView];
    [self.contentView setEditable:YES];
    __weak typeof(self) _weakRef = self;
    [self.contentView setPickBlock: (AvatarPickerBlock)^{
        UzysAssetsPickerController * imagePicker = [[UzysAssetsPickerController alloc]init];
        imagePicker.assetsFilter = [ALAssetsFilter allPhotos];
        imagePicker.delegate = (id<UzysAssetsPickerControllerDelegate>)_weakRef;
        imagePicker.maximumNumberOfSelectionPhoto = 1;
        imagePicker.maximumNumberOfSelectionVideo = 0;
        [_weakRef presentViewController:imagePicker animated:YES completion:nil];
        CFRunLoopRun();
        return [UIImage imageWithCGImage: _weakRef.asset.defaultRepresentation.fullResolutionImage];
    }];
}

- (BOOL)allFieldsTexted
{
    return
    ![self.contentView.nickNameField.text isBlank] &&
    ![self.contentView.ageField.text isBlank] &&
    ![self.contentView.cityField.text isBlank];
}

@end
