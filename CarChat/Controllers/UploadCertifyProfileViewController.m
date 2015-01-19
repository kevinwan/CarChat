//
//  UploadCertifyProfileViewController.m
//  CarChat
//
//  Created by 赵佳 on 15/1/19.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UploadCertifyProfileViewController.h"
#import <UzysAssetsPickerController.h>
#import "NSString+Helpers.h"

@interface UploadCertifyProfileViewController ()
@property (nonatomic, copy) NSString * userID;
@property (weak, nonatomic) IBOutlet UITextField *plateNOFiled;
@property (weak, nonatomic) IBOutlet UIButton *scanLicenseButton;
@property (nonatomic, strong) ALAsset * asset;

@end

@implementation UploadCertifyProfileViewController

#pragma mark - Lifecycle
- (instancetype)initWithUserId:(NSString *)userId
{
    if (self = [super init]) {
        self.userID = userId;
        
        return self;
    }
    return nil;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.plateNOFiled];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"车主认证";
    [self setRightNavigationBarItem:@"提交"
                             target:self
                          andAction:@selector(submit)];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enableSubmitButton)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.plateNOFiled];
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
    [self.scanLicenseButton setTitle:nil forState:UIControlStateNormal];
    [self.scanLicenseButton setBackgroundImage:[UIImage imageWithCGImage: self.asset.defaultRepresentation.fullResolutionImage] forState:UIControlStateNormal];
    [self enableSubmitButton];
}

- (void)UzysAssetsPickerControllerDidCancel:(UzysAssetsPickerController *)picker
{
    [self enableSubmitButton];
}

- (void)UzysAssetsPickerControllerDidExceedMaximumNumberOfSelection:(UzysAssetsPickerController *)picker
{
    return;
}

#pragma mark - User Interaction
- (void)submit
{
    // TODO: network request
}

- (IBAction)pickLicenseImage:(id)sender
{
    UzysAssetsPickerController * imagePicker = [[UzysAssetsPickerController alloc]init];
    imagePicker.assetsFilter = [ALAssetsFilter allPhotos];
    imagePicker.delegate = (id<UzysAssetsPickerControllerDelegate>)self;
    imagePicker.maximumNumberOfSelectionPhoto = 1;
    imagePicker.maximumNumberOfSelectionVideo = 0;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - Internal Helper
- (void)enableSubmitButton
{
    [self.navigationItem.rightBarButtonItem setEnabled:(![self.plateNOFiled.text isBlank]) && self.asset];
}

@end
