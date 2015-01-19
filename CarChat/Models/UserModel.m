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

@end

@implementation UserModel (icons)

- (UIImage *)genderImage
{
    return [[UIImage imageWithColor:self.gender == GenderMale ? [UIColor  blueColor] : [UIColor  redColor]] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
}

@end