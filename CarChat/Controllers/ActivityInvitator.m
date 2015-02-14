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
#import "UserModel+helper.h"

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
    CertifyStatus st = [UserModel currentUserCertifyStatus];
    if (st == CertifyStatusVerifyed) {
        UIActionSheet * as = [[UIActionSheet alloc]initWithTitle:@"发送邀请"
                                                        delegate:(id<UIActionSheetDelegate>)self
                                               cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                               otherButtonTitles:@"短信", @"邮件", @"微信好友", @"微信朋友圈", nil];
        [as showInView:self.targetVc.view];
    }
    else if (st == CertifyStatusVerifying) {
        UIAlertView * a = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"您的认证材料正在审核，审核通过后方可发起邀请" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [a show];
    }
    else if (st == CertifyStatusUnverifyed) {
        UIAlertView * a = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"只有认证车主才能发出活动邀请，请在“我的”页面上传认证材料" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [a show];
    }
    
    
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
                smsSender.body = kInviteTextContentWithInviteCode(self.activity.invitationCode);
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
                [mailSender setSubject:self.activity.name];
                [mailSender setMessageBody:kInviteTextContentWithInviteCode(self.activity.invitationCode) isHTML:NO];
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
