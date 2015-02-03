//
//  ConcreteResponseObject.m
//  CarChat
//
//  Created by Develop on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ConcreteResponseObject.h"
#import <objc/runtime.h>

const char * notifyKeyError = "respError";
const NSString * const ResponseUserInfoParameterKey = @"parameter";

@implementation NSNotification (ResponseObject)

+ (instancetype)responseObjectWithApi:(NSString *)api object:(id)object andRequestParameter:(ABCParameter *)parameter
{
    return [[self class] notificationWithName:api object:object userInfo:@{ResponseUserInfoParameterKey:parameter}];
}

- (NSString *)api
{
    return self.name;
}

- (id)responseObject
{
    return self.object;
}

- (ABCParameter *)parameter
{
    return self.userInfo[ResponseUserInfoParameterKey];
}

- (void)setError:(NSError *)error
{
    objc_setAssociatedObject(self, notifyKeyError, error, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSError *)error
{
    return (NSError *)objc_getAssociatedObject(self, notifyKeyError);
}

@end
