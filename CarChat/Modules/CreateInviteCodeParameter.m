//
//  CreateInviteCodeParameter.m
//  CarChat
//
//  Created by 赵佳 on 15/1/15.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "CreateInviteCodeParameter.h"

@implementation CreateInviteCodeParameter

- (NSDictionary *)toDic
{
    return @{@"activityId":self.activityIdentifier};
}

@end
