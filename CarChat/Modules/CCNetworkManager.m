//
//  CCNetworkManager.m
//  CarChat
//
//  Created by 赵佳 on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "CCNetworkManager.h"
#import <AFNetworking/AFNetworking.h>

static NSString * const baseUrl = @"http://www.baidu.com/";
NSString * const ApiLogin = @"";
NSString * const ApiRegister = @"";
NSString * const ApiResetPassword = @"";
NSString * const ApiGetVerifySMS = @"";
NSString * const ApiSetPersonalInfo = @"";
NSString * const ApiGetUserInfo = @"";
NSString * const ApiSubmitCertificationProfile = @"";
NSString * const ApiGetSuggestActivities = @"";
NSString * const ApiGetMyActivities = @"";
NSString * const ApiGetActivitiesDetail = @"";
NSString * const ApiGetCommentsInActivity = @"";
NSString * const ApiReplyActivity = @"";
NSString * const ApiCreateActivity = @"";
NSString * const ApiInviteUsers = @"";
NSString * const ApiChatToUser = @"";
NSString * const ApiFollowUser = @"";
NSString * const ApiUnfollowUser = @"";
NSString * const ApiGetFollowing = @"";
NSString * const ApiGetFollowers = @"";


@interface CCNetworkManager ()

@property (nonatomic, strong) AFHTTPRequestOperationManager * requestManager;

@end


@implementation CCNetworkManager

+ (instancetype)defaultManager
{
    static CCNetworkManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
        instance.requestManager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:baseUrl]];
    });
    return instance;
}

- (void)addObserver:(NSObject<CCNetworkResponse> *)observer forApi:(NSString *)api
{
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(didGetResponseNotification:) name:api object:nil];
}

- (void)removeObserver:(NSObject *)observer forApi:(NSString *)api
{
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:api object:nil];
}

- (void)requestApi:(NSString *)api withParameters:(RequestArgument *)parameters
{
    [self _requestApi:api withParameters:parameters];
}

#pragma mark - Internal Helper
- (void)_requestApi:(NSString *)api withParameters:(RequestArgument *)parameters
{
    [self.requestManager GET:api
                  parameters:parameters.toDic
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                         [[NSNotificationCenter defaultCenter] postNotificationName:api object:@{} userInfo:parameters.toDic];
                     }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         [[NSNotificationCenter defaultCenter] postNotificationName:api object:[NSError errorWithDomain:@"" code:0 userInfo:parameters.toDic]];
                     }];
}

@end
