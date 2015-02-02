//
//  CCStatusProvider.m
//  CarChat
//
//  Created by Develop on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//


#import "CCStatusManager.h"
#import <AVOSCloud/AVOSCloud.h>
#import "Common.h"

@implementation CCStatusManager

+ (instancetype)defaultManager
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc]init];
    });
    return instance;
}




@end
