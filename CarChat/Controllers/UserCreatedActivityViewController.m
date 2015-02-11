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
#import "UserModel+Helper.h"
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"

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
    
    if ([self.activity.owner.identifier isEqualToString:[UserModel currentUserId]]) {
        // 当前用户创建的活动
        [self setRightNavigationBarItem:@"邀请" target:self andAction:@selector(invite)];
    }
    
    [self setupContentView];
}

#pragma mark - User Interaction
- (void)invite
{
    UIActionSheet * as = [[UIActionSheet alloc]initWithTitle:@"发送邀请"
                                                    delegate:(id<UIActionSheetDelegate>)self
                                           cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                           otherButtonTitles:@"短信", @"邮件", @"微信好友", @"微信朋友圈", nil];
    [as showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            // 短信
        {
            if( [MFMessageComposeViewController canSendText] )// 判断设备能不能发送短信
            {
                MFMessageComposeViewController * smsSender = [[MFMessageComposeViewController alloc] init];
                smsSender.messageComposeDelegate= (id<MFMessageComposeViewControllerDelegate>)self;
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
            break;
        case 1:
            // 邮件
        {
            if ([MFMailComposeViewController canSendMail]) {
                MFMailComposeViewController * mailSender = [[MFMailComposeViewController alloc]init];
                [mailSender setMailComposeDelegate:(id<MFMailComposeViewControllerDelegate>)self];
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
            break;
        case 2:
            // 微信好友
        {
            AppDelegate * d = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [d sendInviteCodeToWX:self.activity.invitationCode via:SendingInvitationViaWXSession];
        }
            break;
        case 3:
            // 朋友圈
        {
            AppDelegate * d = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [d sendInviteCodeToWX:self.activity.invitationCode via:SendingInvitationViaWXTimeLine];
        }
            break;
        default:
            break;
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

#pragma mark - Internal Helper
- (void)setupContentView
{
    UserCreatActivityDescriptionView * view = [UserCreatActivityDescriptionView view];
    [view layoutWithModel:self.activity];
    __weak typeof(self) _weakRef = self;
    [view setViewParticipantsBlock:^{
        [ControllerCoordinator goNextFrom:_weakRef whitTag:kShowParticipantsTag andContext:_weakRef.activity.identifier];
    }];
    [self.view addSubview:view];
    
    CommentViewController * comment = [[CommentViewController alloc]initWithActivityId:self.activity.identifier];
    [comment.view setFrame:self.view.bounds];
    [comment setListHeaderView:view];
    [self addChildViewController:comment];
    [self.view addSubview:comment.view];
    [comment didMoveToParentViewController:self];
}

@end
