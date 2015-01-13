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

@interface CompletePersonalInfoViewController ()

@property (nonatomic, strong) ALAsset * asset;

@end

@implementation CompletePersonalInfoViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"个人信息";
    [self.navigationItem setLeftBarButtonItem:nil];
    [self setRightNavigationBarItem:@"完成"
                             target:self
                          andAction:@selector(completeInfoDone)];
    
    PersonalInfoView * infoView = [PersonalInfoView view];
    [infoView setFrame:self.view.bounds];
    [self.view addSubview:infoView];
    [infoView setEditable:YES];
    __weak typeof(self) _weakRef = self;
    [infoView setPickBlock: (AvatarPickerBlock)^{
        UzysAssetsPickerController * imagePicker = [[UzysAssetsPickerController alloc]init];
        imagePicker.assetsFilter = [ALAssetsFilter allPhotos];
        imagePicker.delegate = (id<UzysAssetsPickerControllerDelegate>)_weakRef;
        imagePicker.maximumNumberOfSelectionPhoto = 1;
        imagePicker.maximumNumberOfSelectionVideo = 0;
        [self presentViewController:imagePicker animated:YES completion:nil];
        CFRunLoopRun();
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UzysAssetsPickerControllerDelegate
- (void)UzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    LOG_EXPR(assets);
}

- (void)UzysAssetsPickerControllerDidCancel:(UzysAssetsPickerController *)picker
{
    
}

- (void)UzysAssetsPickerControllerDidExceedMaximumNumberOfSelection:(UzysAssetsPickerController *)picker
{
    
}

#pragma mark - User Interaction
- (void)completeInfoDone
{
    [self dismissSelf];
}

@end
