//
//  ReplyInvitationParameter.h
//  CarChat
//
//  Created by Jia Zhao on 1/31/15.
//  Copyright (c) 2015 GongPingJia. All rights reserved.
//

#import "ABCParameter.h"

@interface ReplyInvitationParameter : ABCParameter

@property (nonatomic, strong) NSString * invitedActivityId;
@property (nonatomic, assign) BOOL accepted;

@end
