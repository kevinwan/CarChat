//
//  ResetPasswordParameter.h
//  CarChat
//
//  Created by Develop on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ABCParameter.h"

@interface ResetPasswordParameter : ABCParameter

@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSString * verifyCode;
@property (nonatomic, strong) NSString * theNewPassword;

@end
