//
//  InviteViewController.m
//  CarChat
//
//  Created by 赵佳 on 15/1/15.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "InviteViewController.h"
#import "CreateInvitationParameter.h"
#import <MessageUI/MessageUI.h>
#import "CollectionDelegator.h"
#import "AppDelegate.h"

static NSString * const cellIdentifier = @"inviteCell";

static NSString * const InviteItemWXTimeLine = @"微信朋友圈";
static NSString * const InviteItemWXChat = @"微信好友";
static NSString * const InviteItemSMS = @"短信";
static NSString * const InviteItemEMAIL = @"邮件";
static NSString * const InviteItemFollowing = @"我关注的人";
static NSString * const InviteItemFollower = @"关注我的人";

@interface InviteViewController () <MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) ActivityModel *activity;
@property (weak, nonatomic) IBOutlet UITableView *inviteTableView;
@property (nonatomic, strong) CollectionDelegator * inviteTableDelegator;
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
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiCreateInvitation];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"邀请好友";
    [self setLeftNavigationBarItem:@"关闭"
                            target:self
                         andAction:@selector(close)];
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiCreateInvitation];
    
    
    self.inviteItems = @[InviteItemWXTimeLine,
                         InviteItemWXChat,
                         InviteItemFollowing,
                         InviteItemFollower,
                         InviteItemSMS,
                         InviteItemEMAIL];
    
    [self setupDelegator];
    
    if (!self.activity.invitationCode) {
        [self requestInvitationCode];
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
        [self showTip:response.error.localizedDescription];
        // TODO: 创建/获取邀请码失败，应该做点什么。。。。。。
    }
    else {
        // successed
        self.activity.invitationCode = response.object;
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

- (void)inviteViaWXTimeLine
{
    AppDelegate * d = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [d sendInviteCodeToWX:self.activity.invitationCode via:SendingInvitationViaWXTimeLine];
}

- (void)inviteViaWXSession
{
    AppDelegate * d = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [d sendInviteCodeToWX:self.activity.invitationCode via:SendingInvitationViaWXSession];
}

- (void)inviteViaSMS
{
    if( [MFMessageComposeViewController canSendText] )// 判断设备能不能发送短信
    {
        MFMessageComposeViewController * smsSender = [[MFMessageComposeViewController alloc] init];
        smsSender.messageComposeDelegate= self;
        // TODO: 编辑分享内容
        smsSender.body = self.activity.invitationCode;
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
        [mailSender setMessageBody:self.activity.invitationCode isHTML:NO];
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

#pragma mark - Internal Helper
- (void)setupDelegator
{
    self.inviteTableDelegator = [[CollectionDelegator alloc]initWithItems:self.inviteItems andCellIdentifier:cellIdentifier];
    [self.inviteTableDelegator setConfigBlock: ^(NSString * item, UITableViewCell * cell) {
        cell.textLabel.text = item;
    }];
    __weak typeof(self) weakref = self;
    [self.inviteTableDelegator setSelectingBlock: ^(NSString * item) {
        if (item == InviteItemWXTimeLine) {
            [weakref inviteViaWXTimeLine];
        }
        else if (item == InviteItemWXChat) {
            [weakref inviteViaWXSession];
        }
        else if (item == InviteItemSMS) {
            [weakref inviteViaSMS];
        }
        else {
            [weakref iniviteViaEmail];
        }
    }];
    [self.inviteTableView setDelegate:self.inviteTableDelegator];
    [self.inviteTableView setDataSource:self.inviteTableDelegator];
}

- (void)requestInvitationCode
{
    CreateInvitationParameter * par = (CreateInvitationParameter *)[ParameterFactory parameterWithApi:ApiCreateInvitation];
    [par setActivityIdentifier:self.activity.identifier];
    [[CCNetworkManager defaultManager] requestWithParameter:par];
}

@end
