//
//  UserModel.h
//  CarChat
//
//  Created by Develop on 15/1/13.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"

@interface UserModel : NSObject

@property (nonatomic, copy) NSString * identifier;
@property (nonatomic, copy) NSString * phone;
@property (nonatomic, copy) NSString * nickName;
@property (nonatomic, copy) NSString * age;
@property (nonatomic, copy) NSString * avatar;
@property (nonatomic, strong) NSArray * certifications;
@property (nonatomic, assign) Gender gender;
@property (nonatomic, readonly) NSString * genderString;
@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * countOfActvity;
@property (nonatomic, copy) NSString * countOfFollowing;
@property (nonatomic, copy) NSString * countOfFollower;
@property (nonatomic, assign) NSInteger relationship;
@property (nonatomic, assign) NSInteger certifyStatus;

@end

@interface UserModel (icons)
- (UIImage *)genderImage;
@end