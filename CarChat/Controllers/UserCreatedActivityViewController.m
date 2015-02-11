//
//  UserCreatedActivityViewController.m
//  CarChat
//
//  Created by Develop on 15/1/21.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UserCreatedActivityViewController.h"
#import "UserCreatActivityDescriptionView.h"
#import "CommentViewController.h"
#import "UIView+frame.h"

@interface UserCreatedActivityViewController ()

@property (nonatomic, strong) ActivityModel * activity;

@end

@implementation UserCreatedActivityViewController

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

- (void)dealloc
{
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"活动详情";
    
    [self setupContentView];
    
}

#pragma mark - User Interaction

#pragma mark - Internal Helper
- (void)setupContentView
{
    UserCreatActivityDescriptionView * view = [UserCreatActivityDescriptionView view];
    [view layoutWithModel:self.activity];
    [self.view addSubview:view];
    
    CommentViewController * comment = [[CommentViewController alloc]initWithActivityId:self.activity.identifier];
    [comment.view setFrame:self.view.bounds];
    [comment setListHeaderView:view];
    [self addChildViewController:comment];
    [self.view addSubview:comment.view];
    [comment didMoveToParentViewController:self];
}

@end
