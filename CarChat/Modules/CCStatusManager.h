//
//  CCStatusProvider.h
//  CarChat
//
//  Created by Develop on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  用于检查应用内的状态，比如邀请码状态，邀请状态，登录状态等等
 */
@interface CCStatusManager : NSObject

+ (instancetype)defaultManager;

@property (nonatomic, copy) NSString * verifyedInviteCode;

@end
