//
//  CreateInviteCodeParameter.m
//  CarChat
//
//  Created by 赵佳 on 15/1/15.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "CreateInvitationParameter.h"

@implementation CreateInvitationParameter

- (NSDictionary *)toDic
{
    return @{@"activityId":self.activityIdentifier};
}

@end
