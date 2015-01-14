//
//  RegisterParameter.m
//  CarChat
//
//  Created by Develop on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "RegisterParameter.h"

@implementation RegisterParameter

- (NSDictionary *)toDic
{
    return @{@"phone":self.phone,
             @"verifyCode":self.verifyCode,
             @"password":self.pwd};
}

@end
