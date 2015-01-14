//
//  GetVerifyCodeParameter.m
//  CarChat
//
//  Created by Develop on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "GetVerifySMSParameter.h"

@implementation GetVerifySMSParameter

- (NSDictionary *)toDic
{
    return @{@"phone":self.phone};
}

@end
