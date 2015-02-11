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

- (NSString *)payTypeText
{
    return [[self class] textFromPayType:self.payType];
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

+ (NSString *)textFromPayType:(PayType)type
{
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

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    ActivityModel * model = [[ActivityModel alloc]init];
    model.identifier = [self.identifier copyWithZone:zone];
    model.name = [self.name copyWithZone:zone];
    model.posterUrl = [self.posterUrl copyWithZone:zone];
    model.posterImage = [UIImage imageWithCGImage:[self.posterImage CGImage]];
    model.destination = [self.destination copyWithZone:zone];
    model.fromDate = [self.fromDate copyWithZone:zone];
    model.toDate = [self.toDate copyWithZone:zone];
    model.toplimit = [self.toplimit copyWithZone:zone];
    model.payType = self.payType;
    model.cost = [self.cost copyWithZone:zone];
    model.owner = [self.owner copyWithZone:zone];
    model.createDate = [self.createDate copyWithZone:zone];
    model.updateDate = [self.updateDate copyWithZone:zone];
    model.invitationCode = [self.invitationCode copyWithZone:zone];
    model.notice = [self.notice copyWithZone:zone];
    model.countOfParticipants = [self.countOfParticipants copyWithZone:zone];
    return model;
}

@end
