//
//  CreateActivityParameter.m
//  CarChat
//
//  Created by 赵佳 on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "CreateActivityParameter.h"

@implementation CreateActivityParameter

- (NSDictionary *)toDic
{
    return
    @{@"name":self.name,
      @"destination":self.destination,
      @"fromDate":self.fromDate,
      @"toDate":self.toDate,
//      @"toplimit":self.toplimit,
      @"payType":@(self.payType),
//      @"cost":self.cost,
      @"notice":self.notice};
}

@end
