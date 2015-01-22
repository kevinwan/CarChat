//
//  MyProfileCard.h
//  CarChat
//
//  Created by Develop on 15/1/19.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"


@interface UserProfileCard : UIView

+ (instancetype)view;

- (void)layoutWithUser:(UserModel *)user;

- (CGFloat)height;

@property (nonatomic, strong) void(^activityTouched)(void);
@property (nonatomic, strong) void(^followingTouched)(void);
@property (nonatomic, strong) void(^followerTouched)(void);
@property (nonatomic, strong) void(^relationshipTouched)(void);

@end
