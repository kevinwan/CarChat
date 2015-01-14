//
//  CCNetworkManager.m
//  CarChat
//
//  Created by 赵佳 on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "CCNetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "ConcreteResponseObject.h"

const NSString * const ResponseUserInfoParameterKey = @"parameter";

static NSString * const baseUrl = @"http://www.baidu.com/";

NSString * const ApiLogin = @"Login";
NSString * const ApiRegister = @"Register";
NSString * const ApiValidateInviteCode = @"ValidateInviteCode";
NSString * const ApiGetActivityWithInviteCode = @"GetActivityWithInviteCode";
NSString * const ApiResetPassword = @"ResetPassword";
NSString * const ApiGetVerifySMS = @"GetVerifySMS";
NSString * const ApiSetPersonalInfo = @"SetPersonalInfo";
NSString * const ApiGetUserInfo = @"GetUserInfo";
NSString * const ApiSubmitCertificationProfile = @"SubmitCertificationProfile";
NSString * const ApiGetSuggestActivities = @"GetSuggestActivities";
NSString * const ApiGetMyActivities = @"GetMyActivities";
NSString * const ApiGetActivitiesDetail = @"GetActivitiesDetail";
NSString * const ApiGetCommentsInActivity = @"GetCommentsInActivity";
NSString * const ApiReplyActivity = @"ReplyActivity";
NSString * const ApiCreateActivity = @"CreateActivity";
NSString * const ApiCreateInviteCode = @"CreateInviteCode";
NSString * const ApiInviteUsers = @"InviteUsers";
NSString * const ApiReplyInvitation = @"ReplyInvitation";
NSString * const ApiChatToUser = @"ChatToUser";
NSString * const ApiFollowUser = @"FollowUser";
NSString * const ApiUnfollowUser = @"UnfollowUser";
NSString * const ApiGetFollowing = @"GetFollowing";
NSString * const ApiGetFollowers = @"GetFollowers";


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

- (void)requestWithParameter:(ABCParameter *)parameter
{
    ConcreteResponseObject * responseObj = [ConcreteResponseObject responseObjectWithApi:parameter.api
                                                                                  object:@{}
                                                                     andRequestParameter:parameter];
    [[NSNotificationCenter defaultCenter] postNotification:responseObj];
    return;
    
//    [self _requestApi:parameter.api withParameters:parameters];
}

#pragma mark - Internal Helper
- (void)_requestApi:(NSString *)api withParameters:(ABCParameter *)parameters
{
    [self.requestManager GET:api
                  parameters:parameters.toDic
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                         ConcreteResponseObject * responseObj = [ConcreteResponseObject responseObjectWithApi:parameters.api
                                                                                                       object:@{}
                                                                                          andRequestParameter:parameters];
                         [[NSNotificationCenter defaultCenter] postNotification:responseObj];
                     }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         ConcreteResponseObject * responseObj = [ConcreteResponseObject responseObjectWithApi:parameters.api object:nil andRequestParameter:parameters];
                         [responseObj setError:error];
                         [[NSNotificationCenter defaultCenter] postNotification:responseObj];
                     }];
}

@end
