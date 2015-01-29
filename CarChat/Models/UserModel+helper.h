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

@end
