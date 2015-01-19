//
//  InviteViewController.m
//  CarChat
//
//  Created by 赵佳 on 15/1/15.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "InviteViewController.h"
#import "CreateInviteCodeParameter.h"
#import "InviteTableDelegator.h"
#import <MessageUI/MessageUI.h>

static NSString * const cellIdentifier = @"inviteCell";
static NSString * const InviteItemWXTimeLine = @"微信朋友圈";
static NSString * const InviteItemWXChat = @"微信好友";
static NSString * const InviteItemSMS = @"短信";
static NSString * const InviteItemEMAIL = @"邮件";

@interface InviteViewController () <MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) ActivityModel *activity;
@property (nonatomic, strong) NSString * inviteCode;
@property (weak, nonatomic) IBOutlet UITableView *inviteTableView;
@property (nonatomic, strong) InviteTableDelegator * inviteTableDelegator;
@property (nonatomic, strong) NSArray * inviteItems;

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

- (void)dealloc
{
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiCreateInviteCode];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"邀请好友";
    [self setLeftNavigationBarItem:@"关闭"
                            target:self
                         andAction:@selector(close)];
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiCreateInviteCode];
    
    
    self.inviteItems = @[InviteItemWXTimeLine, InviteItemWXChat, InviteItemSMS, InviteItemEMAIL];
    self.inviteTableDelegator = [[InviteTableDelegator alloc]initWithItems:self.inviteItems cellIdentifier:cellIdentifier];
    [self.inviteTableDelegator setConfigBlock: ^(NSString * item, UITableViewCell * cell) {
        cell.textLabel.text = item;
    }];
    __weak typeof(self) weakref = self;
    [self.inviteTableDelegator setSelectingBlock: ^(NSString * item) {
        if (item == InviteItemWXTimeLine) {
            [weakref inviteViaWXTimeLine];
        }
        else if (item == InviteItemWXChat) {
            [weakref inviteViaWXChat];
        }
        else if (item == InviteItemSMS) {
            [weakref inviteViaSMS];
        }
        else {
            [weakref iniviteViaEmail];
        }
    }];
    [self.inviteTableView setDelegate:(id<UITableViewDelegate>)self.inviteTableDelegator];
    [self.inviteTableView setDataSource:(id<UITableViewDataSource>)self.inviteTableDelegator];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 没有邀请码，要去服务器创建一个邀请码
    if (!self.inviteCode) {
        [self showLoading:nil];
        CreateInviteCodeParameter * parameter = (CreateInviteCodeParameter *)[ParameterFactory parameterWithApi:ApiCreateInviteCode];
        parameter.activityIdentifier = self.activity.identifier;
        [[CCNetworkManager defaultManager] requestWithParameter:parameter];
    }
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
        // failed
    }
    else {
        // successed
        self.inviteCode = response.object;
    }
}

#pragma mark - MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    /*
     MessageComposeResultCancelled,
     MessageComposeResultSent,
     MessageComposeResultFailed
     */
    [controller dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    /*
     MFMailComposeResultCancelled,
     MFMailComposeResultSaved,
     MFMailComposeResultSent,
     MFMailComposeResultFailed
     */
    [controller dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - User Interaction
- (void)close
{
    [ControllerCoordinator goNextFrom:self
                              whitTag:InviteCloseButtonItemTag
                           andContext:nil];
}

#pragma mark - Internal Helper
- (void)inviteViaWXTimeLine
{
    
}

- (void)inviteViaWXChat
{
    
}

- (void)inviteViaSMS
{
    if( [MFMessageComposeViewController canSendText] )// 判断设备能不能发送短信
    {
        MFMessageComposeViewController * smsSender = [[MFMessageComposeViewController alloc] init];
        smsSender.messageComposeDelegate= self;
        // TODO: 编辑分享内容
        smsSender.body = self.inviteCode;
        [self presentViewController:smsSender animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意"
                                                        message:@"您的设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)iniviteViaEmail
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController * mailSender = [[MFMailComposeViewController alloc]init];
        [mailSender setMailComposeDelegate:self];
        // TODO: 编辑邮件内容
        [mailSender setSubject:self.activity.name];
        [mailSender setMessageBody:self.inviteCode isHTML:NO];
        [self.navigationController presentViewController:mailSender animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意"
                                                        message:@"您的设备不支持邮件功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
