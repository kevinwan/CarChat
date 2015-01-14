//
//  ActivityModel.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel

- (CreateActivityParameter *)parameter
{
    CreateActivityParameter *parameter = (CreateActivityParameter *)[ParameterFactory parameterWithApi:ApiCreateActivity];
    // TODO:
    return parameter;
}

+ (instancetype)ActivityWithParameter:(CreateActivityParameter *)parameter
{
    ActivityModel * model = [ActivityModel new];
    // TODO:
    return model;
}

@end
