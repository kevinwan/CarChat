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

+ (BOOL)isCurrentUser:(UserModel *)user
{
    return [self isCurrentUserId:user.identifier];
}

+ (BOOL)userIsCurrentUserFollowee:(UserModel *)user
{
    return (user.relationship & RelationshipFollowing) != 0;
}

+ (BOOL)userIsCurrentUserFollower:(UserModel *)user
{
    return (user.relationship & RelationshipFollower) != 0;
}

+ (NSString *)currentUserId
{
    return [AVUser currentUser].objectId;
}
+ (BOOL)isLoged
{
    return [AVUser currentUser] != nil;
}

+ (BOOL)isCurrentUserVerifyed
{
    AVUser * current = [AVUser currentUser];
    return [[current objectForKey:@"certifyStatus"] integerValue] == CertifyStatusVerifyed;
}

+ (BOOL)isCurrentUserId:(NSString *)identifier
{
    return [[[AVUser currentUser] objectId] isEqualToString:identifier];
}
@end
