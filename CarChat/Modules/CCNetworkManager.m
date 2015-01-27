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
#import <AVOSCloud/AVOSCloud.h>
#import "GetVerifySMSParameter.h"
#import "ValidateVerifyCodeParameter.h"
#import "ValidateInviteCodeParameter.h"
#import "RegisterParameter.h"
#import "SetPersonalInfoParameter.h"

const NSString * const ResponseUserInfoParameterKey = @"parameter";

static NSString * const baseUrl = @"http://www.baidu.com/";

NSString * const ApiLogin = @"Login";
NSString * const ApiRegister = @"Register";
NSString * const ApiValidateInviteCode = @"ValidateInviteCode";
NSString * const ApiGetActivityWithInviteCode = @"GetActivityWithInviteCode";
NSString * const ApiResetPassword = @"ResetPassword";
NSString * const ApiGetVerifySMS = @"GetVerifySMS";
NSString * const ApiValidateVerifyCode = @"ValidateVerifyCode";
NSString * const ApiSetPersonalInfo = @"SetPersonalInfo";
NSString * const ApiGetUserInfo = @"GetUserInfo";
NSString * const ApiSubmitCertificationProfile = @"SubmitCertificationProfile";
NSString * const ApiGetSuggestActivities = @"GetSuggestActivities";
NSString * const ApiGetUserActivities = @"GetUserActivities";
NSString * const ApiGetActivitiesDetail = @"GetActivitiesDetail";
NSString * const ApiGetCommentsInActivity = @"GetCommentsInActivity";
NSString * const ApiReplyActivity = @"ReplyActivity";
NSString * const ApiCreateActivity = @"CreateActivity";
NSString * const ApiCreateInvitation = @"CreateInvitation";
NSString * const ApiInviteUsers = @"InviteUsers";
NSString * const ApiReplyInvitation = @"ReplyInvitation";
NSString * const ApiChatToUser = @"ChatToUser";
NSString * const ApiFollowUser = @"FollowUser";
NSString * const ApiUnfollowUser = @"UnfollowUser";
NSString * const ApiGetFollowing = @"GetFollowing";
NSString * const ApiGetFollowers = @"GetFollowers";
NSString * const ApiGetParticipants = @"GetParticipants";


@interface CCNetworkManager ()

//@property (nonatomic, strong) AFHTTPRequestOperationManager * requestManager;

@end


@implementation CCNetworkManager

#pragma mark - Public APIs
+ (instancetype)defaultManager
{
    static CCNetworkManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
//        instance.requestManager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:baseUrl]];
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
    NSString * api = parameter.api;
    SEL apiSelector = NSSelectorFromString([api stringByAppendingString:@":"]);
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
    NSAssert([self respondsToSelector:apiSelector], @"api 方法已实现");
    [self performSelector:apiSelector withObject:parameter];
#pragma clang diagnostic pop

#if 0
    ConcreteResponseObject * responseObj = [ConcreteResponseObject responseObjectWithApi:parameter.api
                                                                                  object:@{}
                                                                     andRequestParameter:parameter];
    [[NSNotificationCenter defaultCenter] postNotification:responseObj];
    return;
    
    [self _requestApi:parameter.api withParameters:parameters];
#endif
}

#pragma mark - Internal Helper
- (void)_requestApi:(NSString *)api withParameters:(ABCParameter *)parameters
{
//    [self.requestManager GET:api
//                  parameters:parameters.toDic
//                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                         ConcreteResponseObject * responseObj = [ConcreteResponseObject responseObjectWithApi:parameters.api
//                                                                                                       object:@{}
//                                                                                          andRequestParameter:parameters];
//                         [[NSNotificationCenter defaultCenter] postNotification:responseObj];
//                     }
//                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                         ConcreteResponseObject * responseObj = [ConcreteResponseObject responseObjectWithApi:parameters.api object:nil andRequestParameter:parameters];
//                         [responseObj setError:error];
//                         [[NSNotificationCenter defaultCenter] postNotification:responseObj];
//                     }];
}

#pragma mark - Concrete Request Methods
- (void)Login:(ABCParameter *)parameter
{
}

- (void)Register:(RegisterParameter *)parameter
{
    AVUser * user = [AVUser user];
    user.username = parameter.phone;
    user.password = parameter.pwd;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        ConcreteResponseObject * resp = [ConcreteResponseObject responseObjectWithApi:parameter.api object:nil andRequestParameter:parameter];
        [resp setError:error];
        [[NSNotificationCenter defaultCenter] postNotification:resp];
    }];
}

- (void)ValidateInviteCode:(ValidateInviteCodeParameter *)parameter
{
    ConcreteResponseObject * resp = [ConcreteResponseObject responseObjectWithApi:parameter.api object:@{} andRequestParameter:parameter];
    [[NSNotificationCenter defaultCenter] postNotification:resp];
}

- (void)GetActivityWithInviteCode:(ABCParameter *)parameter
{
}

- (void)ResetPassword:(ABCParameter *)parameter
{
}

- (void)GetVerifySMS:(GetVerifySMSParameter *)parameter
{
    [AVOSCloud requestSmsCodeWithPhoneNumber:parameter.phone callback:^(BOOL succeeded, NSError *error) {
            ConcreteResponseObject * responseObj = [ConcreteResponseObject responseObjectWithApi:parameter.api object:nil andRequestParameter:parameter];
            [responseObj setError:error];
            [[NSNotificationCenter defaultCenter] postNotification:responseObj];
    }];
}

- (void)ValidateVerifyCode:(ValidateVerifyCodeParameter *)paramter
{
    [AVOSCloud verifySmsCode:paramter.verifyCode
           mobilePhoneNumber:paramter.phone
                    callback:^(BOOL succeeded, NSError *error) {
                        ConcreteResponseObject * resp = [ConcreteResponseObject responseObjectWithApi:paramter.api object:nil andRequestParameter:paramter];
                        [resp setError:error];
                        [[NSNotificationCenter defaultCenter] postNotification:resp];
                    }
     ];
}

- (void)SetPersonalInfo:(SetPersonalInfoParameter *)parameter
{
    AVUser * currentUser = [AVUser currentUser];
    [currentUser setObject:parameter.nickName forKey:@"nickName"];
    [currentUser setObject:parameter.age forKey:@"age"];
    [currentUser setObject:parameter.city forKey:@"city"];
    [currentUser setObject:@(parameter.gender) forKey:@"gender"];
    AVFile * avatar = [AVFile fileWithName:@"avatar.jpg" data:parameter.avatar];
    [currentUser setObject:avatar forKey:@"avatar"];
    
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        ConcreteResponseObject * resp = [ConcreteResponseObject responseObjectWithApi:parameter.api object:nil andRequestParameter:parameter];
        [resp setError:error];
        [[NSNotificationCenter defaultCenter] postNotification:resp];
    }];
}

- (void)GetUserInfo:(ABCParameter *)parameter
{
}

- (void)SubmitCertificationProfile:(ABCParameter *)parameter
{
}

- (void)GetSuggestActivities:(ABCParameter *)parameter
{
}

- (void)GetUserActivities:(ABCParameter *)parameter
{
}

- (void)GetActivitiesDetail:(ABCParameter *)parameter
{
}

- (void)GetCommentsInActivity:(ABCParameter *)parameter
{
}

- (void)ReplyActivity:(ABCParameter *)parameter
{
}

- (void)CreateActivity:(ABCParameter *)parameter
{
}

- (void)CreateInvitation:(ABCParameter *)parameter
{
}

- (void)InviteUsers:(ABCParameter *)parameter
{
}

- (void)ReplyInvitation:(ABCParameter *)parameter
{
}

- (void)ChatToUser:(ABCParameter *)parameter
{
}

- (void)FollowUser:(ABCParameter *)parameter
{
}

- (void)UnfollowUser:(ABCParameter *)parameter
{
}

- (void)GetFollowing:(ABCParameter *)parameter
{
}

- (void)GetFollowers:(ABCParameter *)parameter
{
}

- (void)GetParticipants:(ABCParameter *)parameter
{
}

@end
