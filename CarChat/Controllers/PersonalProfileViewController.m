//
//  PersonalProfileViewController.m
//  CarChat
//
//  Created by 赵佳 on 15/1/19.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "PersonalProfileViewController.h"
#import "PersonalInfoView.h"
#import <UzysAssetsPickerController.h>

@interface PersonalProfileViewController ()

@property (nonatomic, strong) UserModel *user;
@property (nonatomic, strong) PersonalInfoView *contentView;
@property (nonatomic, strong) ALAsset * asset;

@end

@implementation PersonalProfileViewController

#pragma mark - Lifecycle
- (instancetype)initWithUserModel:(UserModel *)user
{
    if (self = [super init]) {
        
        self.user = user;
        
        return self;
    }
    return nil;
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"编辑个人资料";
    [self setLeftNavigationBarItem:@"关闭" target:self andAction:@selector(close)];
    [self setRightNavigationBarItem:@"保存" target:self andAction:@selector(save)];
    
    self.contentView = [PersonalInfoView viewWithStyle:PersonalInfoViewStyleAdvance];
    [self.contentView setFrame:self.view.bounds];
    [self.contentView setUser:self.user];
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
    [self.contentView setCertifyBlock: ^(void) {
        [ControllerCoordinator goNextFrom:_weakRef whitTag:MyEditProfileUploadCertifyButtonTag andContext:_weakRef.user.identifier];
    }];
    [self.view addSubview:self.contentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (void)close
{
    [self dismissSelf];
}

- (void)save
{
    [self showLoading:@"正在保存"];
    // TODO: network request
}

@end
