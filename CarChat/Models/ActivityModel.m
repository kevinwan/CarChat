//
//  ActivityModel.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ActivityModel.h"

static NSString * const sbtreat = @"土豪请客";
static NSString * const aa = @"AA";
static NSString * const boyAA = @"男士AA";

@implementation ActivityModel

- (CreateActivityParameter *)parameter
{
    CreateActivityParameter *parameter = (CreateActivityParameter *)[ParameterFactory parameterWithApi:ApiCreateActivity];
    parameter.name = self.name;
    parameter.destination = self.destination;
    parameter.date = self.date;
    parameter.toplimit = self.toplimit;
    parameter.payType = self.payType;
    parameter.cost = self.cost;
    parameter.poster = self.posterData;
    parameter.posterUrl = self.poster;
    return parameter;
}

+ (instancetype)ActivityWithParameter:(CreateActivityParameter *)parameter
{
    ActivityModel * model = [ActivityModel new];
    model.name = parameter.name;
    model.destination = parameter.destination;
    model.date = parameter.date;
    model.toplimit = parameter.toplimit;
    model.payType = parameter.payType;
    model.cost = parameter.cost;
    model.posterData = parameter.poster;
    model.poster = parameter.posterUrl;
    return model;
}

+ (NSString *)stringFromPayType:(PayType)type
{
    if (type == 0) {
        return nil;
    }
    switch (type) {
        case PayTypeSBTreat:
            return sbtreat;
            break;
        case PayTypeEverybodyDutch:
            return aa;
            break;
        case PayTypeBoysDutch:
            return boyAA;
            break;
        default:
            return nil;
            break;
    }
}

+ (PayType)payTypeFromString:(NSString *)string
{
    if ([string isEqualToString:sbtreat]) {
        return PayTypeSBTreat;
    }
    else if ([string isEqualToString:aa]) {
        return PayTypeEverybodyDutch;
    }
    else if ([string isEqualToString:boyAA]) {
        return PayTypeBoysDutch;
    }
    else
    {
        return 0;
    }
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    ActivityModel * model = [[ActivityModel alloc]init];
    model.name = [self.name copyWithZone:zone];
    model.poster = [self.poster copyWithZone:zone];
    model.posterData = [self.posterData copyWithZone:zone];
    model.destination = [self.destination copyWithZone:zone];
    model.date = [self.date copyWithZone:zone];
    model.toplimit = [self.toplimit copyWithZone:zone];
    model.payType = self.payType;
    model.cost = [self.cost copyWithZone:zone];
    model.owner = [self.owner copyWithZone:zone];
    return model;
}

@end
