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
#import "SubmitCertificationProfileParameter.h"

@interface UploadCertifyProfileViewController ()
@property (weak, nonatomic) IBOutlet UITextField *plateNOFiled;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIImageView *plateImageView;
@property (nonatomic, strong) ALAsset * asset;

@end

@implementation UploadCertifyProfileViewController

#pragma mark - Lifecycle

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.plateNOFiled];
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiSubmitCertificationProfile];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"车主认证";
    [self setRightNavigationBarItem:@"提交"
                             target:self
                          andAction:@selector(submit)];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    [self setLeftNavigationBarItem:@"关闭" target:self andAction:@selector(dismissSelf)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshSubmitButton)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.plateNOFiled];
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiSubmitCertificationProfile];
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
        [self showTip:response.error.localizedDescription];
    }
    else {
        [self showTip:@"上传成功" whenDone:^{
            [self dismissSelf];
        }];
    }
}

#pragma mark - UzysAssetsPickerControllerDelegate
- (void)UzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    self.asset = assets[0];
    [self.uploadButton setHidden:YES];
    [self.tipLabel setHidden:YES];
    [self.plateImageView setImage:[UIImage imageWithCGImage: self.asset.aspectRatioThumbnail]];
    [self refreshSubmitButton];
}

- (void)UzysAssetsPickerControllerDidCancel:(UzysAssetsPickerController *)picker
{
    [self refreshSubmitButton];
}

- (void)UzysAssetsPickerControllerDidExceedMaximumNumberOfSelection:(UzysAssetsPickerController *)picker
{
    return;
}

#pragma mark - User Interaction
- (void)submit
{
    [self showLoading:@"正在上传"];
    SubmitCertificationProfileParameter * p = (SubmitCertificationProfileParameter *)[ParameterFactory parameterWithApi:ApiSubmitCertificationProfile];
    p.plateNO = self.plateNOFiled.text;
    p.licenseImage = [UIImage imageWithCGImage:self.asset.defaultRepresentation.fullResolutionImage];
    [[CCNetworkManager defaultManager] requestWithParameter:p];
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
- (void)refreshSubmitButton
{
    [self.navigationItem.rightBarButtonItem setEnabled:(![self.plateNOFiled.text isBlank]) && self.asset];
}

@end
