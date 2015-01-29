//
//  MyViewController.m
//  CarChat
//
//  Created by Develop on 15/1/15.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "MyViewController.h"
#import "UserModel.h"
#import "UIView+frame.h"
#import "UserDetailViewController.h"
#import "CCStatusManager.h"

@interface MyViewController ()

@property (nonatomic, strong) UserDetailViewController * detailVC;

@end

@implementation MyViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我";
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(slapMe)]];
    
    [self setupContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Interaction
- (void)slapMe {
//    [ControllerCoordinator goNextFrom:self whitTag:MyEditProfileTag andContext:self.i];
}

#pragma mark - Internal Helper
-(void)setupContentView
{
    self.detailVC = [[UserDetailViewController alloc]initWithUserId:[CCStatusManager currentUserId]];
    [self.detailVC.view setFrame:self.view.bounds];
    self.detailVC.view.y += 64.f;
    self.detailVC.view.height -= 64.f;
    [self addChildViewController:self.detailVC];
    [self.view addSubview:self.detailVC.view];
    [self.detailVC didMoveToParentViewController:self];
}
@end
