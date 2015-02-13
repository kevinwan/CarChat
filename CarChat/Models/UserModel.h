//
//  UserModel.h
//  CarChat
//
//  Created by Develop on 15/1/13.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject <NSCopying>

@property (nonatomic, copy) NSString * identifier;
@property (nonatomic, assign) UserLevel userLevel;
@property (nonatomic, copy) NSString * phone;
@property (nonatomic, copy) NSString * nickName;
@property (nonatomic, copy) NSString * age;
@property (nonatomic, copy) NSString * avatarUrl;
@property (nonatomic, assign) Gender gender;
@property (nonatomic, readonly) NSString * genderString;
@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSNumber * countOfOwning;
@property (nonatomic, copy) NSNumber * countOfJoining;
@property (nonatomic, copy) NSNumber * countOfFollowing;
@property (nonatomic, copy) NSNumber * countOfFollower;
@property (nonatomic, assign) Relationship relationship;
@property (nonatomic, assign) NSInteger certifyStatus;
@property (nonatomic, copy) NSArray * album;
//@property (nonatomic, strong) NSArray * certifications; // TODO: ?

@end
