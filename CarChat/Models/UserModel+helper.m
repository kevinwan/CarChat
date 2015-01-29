//
//  UserModel+helper.m
//  CarChat
//
//  Created by Develop on 15/1/29.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UserModel+helper.h"
#import "UIImage+color.h"
#import <AVFile.h>

@implementation UserModel (helper)

- (UIImage *)genderImage
{
    switch (self.gender) {
        case GenderMale:
            return [UIImage imageNamed:@"male"];
            break;
        case GenderFemale:
            return [UIImage imageNamed:@"female"];
            break;
        default:
            return [[UIImage imageWithColor:[UIColor blackColor]]stretchableImageWithLeftCapWidth:1 topCapHeight:1];
            break;
    }
}

+ (instancetype)userFromAVUser:(AVUser *)avuser
{
    UserModel * user = [[UserModel alloc]init];
    user.identifier = avuser.objectId;
    user.phone = [avuser objectForKey:@"phone"];
    user.nickName = [avuser objectForKey:@"nickName"];
    user.age = [avuser objectForKey:@"age"];
    user.avatarUrl = [(AVFile *)[avuser objectForKey:@"avatar"] url];
    user.gender = [[avuser objectForKey:@"gender"] integerValue];
    user.city = [avuser objectForKey:@"city"];
    user.countOfActvity = [avuser objectForKey:@"countOfActivity"];
    user.countOfFollowing = [avuser objectForKey:@"countOfFollowing"];
    user.countOfFollower = [avuser objectForKey:@"countOfFollower"];
    user.relationship = [[avuser objectForKey:@"relationship"]integerValue];
    user.certifyStatus = [[avuser objectForKey:@"certifyStatus"]integerValue];
//    user.certifications = ...
    return user;
}
@end
