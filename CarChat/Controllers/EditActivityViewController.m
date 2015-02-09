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

@interface EditActivityViewController ()

@property (nonatomic, strong) ActivityModel * activity;

@property (nonatomic, strong) ALAsset * asset;

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
    // Dispose of any resources that can be recreated.
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
        [_weakRef presentViewController:imagePicker animated:YES completion:nil];
        CFRunLoopRun();
        return [UIImage imageWithCGImage: _weakRef.asset.defaultRepresentation.fullResolutionImage];
    }];
    self.view = v;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.activity != nil) {
        self.navigationItem.title = @"创建活动";
    }
    else {
        self.navigationItem.title = @"编辑活动";
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
@end
