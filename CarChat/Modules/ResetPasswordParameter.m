//
//  ResetPasswordParameter.m
//  CarChat
//
//  Created by Develop on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ResetPasswordParameter.h"

@implementation ResetPasswordParameter

- (NSDictionary *)toDic
{
    return @{@"phone":self.phone,
             @"verifyCode":self.verifyCode,
             @"newPassword":self.theNewPassword};
}

@end
