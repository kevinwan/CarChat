//
//  UserModel.m
//  CarChat
//
//  Created by Develop on 15/1/13.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UserModel.h"
#import "UIImage+color.h"

@implementation UserModel

- (NSString *)genderString
{
    switch (self.gender) {
        case GenderUnknow:
            return @"";
            break;
        case GenderMale:
            return @"Male";
            break;
        case GenderFemale:
            return @"Female";
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
    model.avatar = [self.avatar copyWithZone:zone];
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

@implementation UserModel (icons)

- (UIImage *)genderImage
{
    return [[UIImage imageWithColor:self.gender == GenderMale ? [UIColor  blueColor] : [UIColor  redColor]] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
}

@end