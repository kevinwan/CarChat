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
#import "ReplyActivityView.h"
#import "ReplyActivityParameter.h"

@interface UserCreatedActivityViewController ()

@property (nonatomic, strong) ActivityModel * activity;
@property (nonatomic, strong) UIView * replyView;

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
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiReplyActivity];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"活动详情";
    
    [self setupContentView];
    
    [[CCNetworkManager defaultManager]addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiReplyActivity];
    
}

#pragma mark - CCNetworkResponse
- (void)didGetResponseNotification:(ConcreteResponseObject *)response
{
    [self hideHud];
    
    if (response.error) {
        // fail
        [self showTip:response.error.localizedDescription];
    }
    else {
        [self showTip:@"评论成功"];
        
        [self didPressCancelButton];
    }
}

#pragma mark - ReplyActivityDelegate

- (void)didPressReplyButtonWithContent:(NSString *)content
{
    // go comment
    [self showLoading:@"提交中"];
    ReplyActivityParameter * p = (ReplyActivityParameter *)[ParameterFactory parameterWithApi:ApiReplyActivity];
    p.content = content;
    p.activityIdentifier = self.activity.identifier;
    [[CCNetworkManager defaultManager] requestWithParameter:p];
}

- (void)didPressCancelButton
{
    [self.replyView removeFromSuperview];
}

#pragma mark - User Interaction
- (void)animateReplyView
{
    if (!self.replyView) {
        self.replyView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [self.replyView setBackgroundColor:[UIColor colorWithWhite:.1f alpha:.3f]];
        ReplyActivityView * r = [[ReplyActivityView alloc]initWithDelegate:(id<ReplyActivityDelegate>)self];
        [self.replyView addSubview:r];
        [r setTag:23];
    }
    [(ReplyActivityView *)[self.replyView viewWithTag:23] clear];
    
    [self.view.window addSubview:self.replyView];
}

#pragma mark - Internal Helper
- (void)setupContentView
{
    UserCreatActivityDescriptionView * view = [UserCreatActivityDescriptionView view];
    [view setModel:self.activity];
    [self.view addSubview:view];
    
    CommentViewController * comment = [[CommentViewController alloc]initWithActivityId:self.activity.identifier];
    [comment.view setFrame:self.view.bounds];
    [comment setListHeaderView:view];
    [self addChildViewController:comment];
    [self.view addSubview:comment.view];
    [comment didMoveToParentViewController:self];
    
    UIButton * button = [[UIButton alloc] init];
    [button setFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, 44.f)];
    [button setTitle:@"评论" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(animateReplyView) forControlEvents:UIControlEventTouchUpInside];
    [comment setListFooterView:button];
}

@end
