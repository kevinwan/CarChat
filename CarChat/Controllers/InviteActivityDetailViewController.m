//
//  InviteActivityDetailViewController.m
//  CarChat
//
//  Created by Develop on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "InviteActivityDetailViewController.h"
#import "UserCreatActivityDescriptionView.h"

@interface InviteActivityDetailViewController ()

@property (nonatomic, strong) ActivityModel * activity;

@end

@implementation InviteActivityDetailViewController

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

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"收到邀请";
    [self setLeftNavigationBarItem:@"忽略" target:self andAction:@selector(ignore)];
    [self setRightNavigationBarItem:@"加入" target:self andAction:@selector(join)];
    
    UserCreatActivityDescriptionView * view  = [UserCreatActivityDescriptionView view];
    [view setModel:self.activity];
    [self.view addSubview:view];
}

#pragma mark - User Interaction
- (void)ignore
{
    // TODO: told server ignore it
    
    // then
    [ControllerCoordinator goNextFrom:self whitTag:InviteDetailIgnoreButonItemTag andContext:nil];
}

- (void)join
{
    // TODO: told server join it
    
    // then
    [ControllerCoordinator goNextFrom:self
                              whitTag:InviteDetailJoinButtonItemTag
                           andContext:nil];
}

@end
