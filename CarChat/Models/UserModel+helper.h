//
//  UserModel+helper.h
//  CarChat
//
//  Created by Develop on 15/1/29.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UserModel.h"
#import <AVUser.h>

@interface UserModel (helper)

- (UIImage *)genderImage;

+ (instancetype)userFromAVUser:(AVUser *)avuser;

// 用户是否被当前用户关注
+ (BOOL)userIsCurrentUserFollowee:(UserModel *)user;
// 用户是否关注当前用户
+ (BOOL)userIsCurrentUserFollower:(UserModel *)user;
// 用户是否是当前用户
+ (BOOL)isCurrentUser:(UserModel *)user;


// 当前正在登录的用户
+ (UserModel *)currentUser;
// 当前登陆用户的id
+ (NSString *)currentUserId;
// 是否已登陆
+ (BOOL)isLoged;
// 用户是否已验证
+ (BOOL)isCurrentUserVerifyed;
// 是否是当前登陆用户的id
+ (BOOL)isCurrentUserId:(NSString *)identifier;

@end
