//
//  SetPersonalInfoParameter.h
//  CarChat
//
//  Created by Develop on 15/1/27.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ABCParameter.h"
#import "UserModel.h"

@interface SetPersonalInfoParameter : ABCParameter

@property (nonatomic, copy) NSString * nickName;
@property (nonatomic, assign) Gender gender;
//1:Male
//2:Female
@property (nonatomic, strong) NSData * avatar;
@property (nonatomic, copy) NSString * age;
@property (nonatomic, copy) NSString * city;

@end
