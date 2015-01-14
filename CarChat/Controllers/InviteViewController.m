//
//  InviteViewController.m
//  CarChat
//
//  Created by 赵佳 on 15/1/15.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "InviteViewController.h"

@interface InviteViewController ()

@property (nonatomic, strong) ActivityModel *activity;

@end

@implementation InviteViewController

#pragma mark - Lifecycle
- (instancetype)initWithActivity:(ActivityModel *)activity
{
    if (self = [super init]) {
        self.activity = activity;
    }
    return self;
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"邀请";
    [self setLeftNavigationBarItem:@"关闭"
                            target:self
                         andAction:@selector(close)];
    [self setRightNavigationBarItem:@"发送"
                             target:self
                          andAction:@selector(invite)];
    
    // TODO: 获取邀请码
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Interaction
- (void)close
{
    [ControllerCoordinator goNextFrom:self
                              whitTag:InviteCloseButtonItemTag
                           andContext:nil];
}

- (void)invite
{
}

@end
