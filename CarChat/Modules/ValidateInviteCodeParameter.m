//
//  ValidateInviteCodeParameter.m
//  CarChat
//
//  Created by Develop on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ValidateInviteCodeParameter.h"

@implementation ValidateInviteCodeParameter

- (NSDictionary *)toDic
{
    return @{@"code":_inviteCode};
}

@end
