//
//  ActivityInvitator.m
//  CarChat
//
//  Created by Jia Zhao on 2/12/15.
//  Copyright (c) 2015 GongPingJia. All rights reserved.
//

#import "ActivityInvitator.h"
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"

@interface ActivityInvitator ()

@property (nonatomic, strong) ActivityModel * activity;
@property (nonatomic, weak) UIViewController * targetVc;

@end

@implementation ActivityInvitator

- (instancetype)initWithActivity:(ActivityModel *)activity onViewController:(UIViewController *)targetVC
{
    if (self = [super init]) {
        self.activity = activity;
        self.targetVc = targetVC;
    }
    return self;
}

- (void)show
{
    UIActionSheet * as = [[UIActionSheet alloc]initWithTitle:@"发送邀请"
                                                    delegate:(id<UIActionSheetDelegate>)self
                                           cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                           otherButtonTitles:@"短信", @"邮件", @"微信好友", @"微信朋友圈", nil];
    [as showInView:self.targetVc.view];
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
                [self.targetVc presentViewController:smsSender animated:YES completion:nil];
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
                [self.targetVc.navigationController presentViewController:mailSender animated:YES completion:nil];
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


@end
