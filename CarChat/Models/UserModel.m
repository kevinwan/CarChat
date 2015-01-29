//
//  UserModel.m
//  CarChat
//
//  Created by Develop on 15/1/13.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (NSString *)genderString
{
    switch (self.gender) {
        case GenderUnknow:
            return @"";
            break;
        case GenderMale:
            return @"男";
            break;
        case GenderFemale:
            return @"女";
            break;
        default:
            break;
    }
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    UserModel *model = [[UserModel alloc]init];
    model.phone = [self.phone copyWithZone:zone];
    model.nickName = [self.nickName copyWithZone:zone];
    model.age = [self.age copyWithZone:zone];
    model.avatarUrl = [self.avatarUrl copyWithZone:zone];
    model.certifications = [self.certifications copyWithZone:zone];
    model.gender = self.gender;
    model.city = [self.city copyWithZone:zone];
    model.countOfActvity = [self.countOfActvity copyWithZone:zone];
    model.countOfFollower = [self.countOfFollower copyWithZone:zone];
    model.countOfFollowing = [self.countOfFollowing copyWithZone:zone];
    model.relationship = self.relationship;
    model.certifyStatus = self.certifyStatus;
    
    return model;
}

@end