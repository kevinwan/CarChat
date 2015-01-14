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
#import "NSString+Helpers.h"

@interface CompletePersonalInfoViewController ()

@property (nonatomic, strong) PersonalInfoView * contentView;
@property (nonatomic, strong) ALAsset * asset;

@end

@implementation CompletePersonalInfoViewController

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
    self.contentView = [PersonalInfoView view];
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
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(updateDoneButton)
                                                name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self dismissSelf];
}

#pragma mark - Internal Helper
- (BOOL)allFieldsTexted
{
    return ![self.contentView.nickNameField.text isBlank] && ![self.contentView.ageField.text isBlank] && ![self.contentView.genderField.text isBlank];
}

@end
