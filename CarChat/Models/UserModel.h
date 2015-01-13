//
//  UserModel.h
//  CarChat
//
//  Created by Develop on 15/1/13.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Gender) {
    GenderUnknow = 0,
    GenderMale,
    GenderFemale
};

@interface UserModel : NSObject

@property (nonatomic, strong) NSString * nickName;
@property (nonatomic, strong) NSString * age;
@property (nonatomic, strong) NSString * avatarUrlStr;
@property (nonatomic, strong) NSArray * certifications;
@property (nonatomic, assign) Gender gender;
@property (nonatomic, assign) NSUInteger numOfFollowing;
@property (nonatomic, assign) NSUInteger numOfFollower;

@end
