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
#import "ActivityModel.h"
#import "UserModel+helper.h"
#import "GetVerifySMSParameter.h"
#import "ValidateVerifyCodeParameter.h"
#import "ValidateInviteCodeParameter.h"
#import "RegisterParameter.h"
#import "SetPersonalInfoParameter.h"
#import "CreateActivityParameter.h"
#import "GetSuggestActivitiesParameter.h"
#import "LoginParameter.h"
#import "GetUserInfoParameter.h"
#import "GetUserJoiningActivitiesParameter.h"
#import "GetUserOwningActivitiesParameter.h"
#import "GetFollowingParameter.h"
#import "GetFollowersParameter.h"
#import "FollowUserParameter.h"
#import "UnfollowUserParameter.h"
#import "GetActivityWithInviteCodeParameter.h"
#import "ActivityModel+Helper.h"
#import "ReplyInvitationParameter.h"
#import "GetParticipantsParameter.h"
#import "GetCommentsInActivityParameter.h"
#import "CommentModel.h"
#import "CommentModel+helper.h"
#import "ReplyActivityParameter.h"
// TODO: 整理一下*Parameter.h

static NSString * const baseUrl = @"http://www.baidu.com/";

// 2.登录
NSString * const ApiLogin = @"Login";
// 3.注册
NSString * const ApiRegister = @"Register";
// 5.验证邀请码
NSString * const ApiValidateInviteCode = @"ValidateInviteCode";
// 6.获取验证码关联的活动
NSString * const ApiGetActivityWithInviteCode = @"GetActivityWithInviteCode";
// 4.重置密码
NSString * const ApiResetPassword = @"ResetPassword";
// 1.获取短信验证码
NSString * const ApiGetVerifySMS = @"GetVerifySMS";
// #.LeanCloud专用
NSString * const ApiValidateVerifyCode = @"ValidateVerifyCode";
// 7.设置个人信息
NSString * const ApiSetPersonalInfo = @"SetPersonalInfo";
// 8.获取用户信息
NSString * const ApiGetUserInfo = @"GetUserInfo";
// 9.提交认证车主材料
NSString * const ApiSubmitCertificationProfile = @"SubmitCertificationProfile";
// 10.获取推荐活动
NSString * const ApiGetSuggestActivities = @"GetSuggestActivities";
// 11.获取用户参加的活动
NSString * const ApiGetUserJoiningActivities = @"GetUserJoiningActivities";
// 12.获取用户创建的活动
NSString * const ApiGetUserOwningActivities = @"GetUserOwningActivities";
// 16.获取活动详情
NSString * const ApiGetActivitiesDetail = @"GetActivitiesDetail";
// 13.获取活动评论
NSString * const ApiGetCommentsInActivity = @"GetCommentsInActivity";
// 14.评论活动
NSString * const ApiReplyActivity = @"ReplyActivity";
// 15.创建活动
NSString * const ApiCreateActivity = @"CreateActivity";
// 17.邀请（应用内的）朋友加入
NSString * const ApiInviteUsers = @"InviteUsers";
// 18.回复邀请
NSString * const ApiReplyInvitation = @"ReplyInvitation";
// 19.聊天
NSString * const ApiChatToUser = @"ChatToUser";
// 20.关注
NSString * const ApiFollowUser = @"FollowUser";
// 21.取关
NSString * const ApiUnfollowUser = @"UnfollowUser";
// 22.获取关注列表
NSString * const ApiGetFollowing = @"GetFollowing";
// 23.获取被关注列表
NSString * const ApiGetFollowers = @"GetFollowers";
// 24.获取活动中的用户
NSString * const ApiGetParticipants = @"GetParticipants";
// 25.上传照片
NSString * const ApiUploadPhotos = @"UploadPhotos";


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
    NSAssert([self respondsToSelector:apiSelector], @"api 方法未实现");
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        [self performSelector:apiSelector withObject:parameter];
    });
#pragma clang diagnostic pop
}

#pragma mark - Internal Helper

- (void)raiseResponseWithObj:(id)obj error:(NSError *)error andRequestParameter:(ABCParameter *)parameter
{
    ConcreteResponseObject * resp = [ConcreteResponseObject responseObjectWithApi:parameter.api object:obj andRequestParameter:parameter];
    [resp setError:error];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotification:resp];
    });
    
}

#pragma mark - Concrete Request Methods
- (void)Login:(LoginParameter *)parameter
{
    
    [AVUser logInWithUsernameInBackground:parameter.phone
                                 password:parameter.pwd
                                    block:
     ^(AVUser *user, NSError *error) {
         [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
     }
     ];
}

- (void)Register:(RegisterParameter *)parameter
{
    AVUser * user = [AVUser user];
    user.username = parameter.phone;
    user.password = parameter.pwd;
    user.mobilePhoneNumber = parameter.phone;
    [user setObject:@1 forKey:@"certifyStatus"];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
    }];
}

- (void)ValidateInviteCode:(ValidateInviteCodeParameter *)parameter
{
    AVQuery * q = [AVQuery queryWithClassName:NSStringFromClass([ActivityModel class])];
    [q whereKey:@"invitationCode" equalTo:parameter.inviteCode];
    [q findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSAssert(objects.count <= 1, @"一个邀请码不能对应多个活动");
        BOOL valid = objects.count > 0;
        [self raiseResponseWithObj:@(valid) error:error andRequestParameter:parameter];
    }];
}

- (void)GetActivityWithInviteCode:(GetActivityWithInviteCodeParameter *)parameter
{
    AVQuery * q = [AVQuery queryWithClassName:NSStringFromClass([ActivityModel class])];
    [q whereKey:@"invitationCode" equalTo:parameter.inviteCode];
    [q includeKey:@"owner"];
    [q findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSAssert(objects.count == 1, @"邀请码对应的对象必须唯一");
        ActivityModel * activity = nil;
        if (objects.count > 0 && error == nil) {
            AVObject * object = objects[0];
            activity = [ActivityModel activityFromAVObject:object];
        }
        [self raiseResponseWithObj:activity error:error andRequestParameter:parameter];
    }];
}

- (void)ResetPassword:(ABCParameter *)parameter
{
}

- (void)GetVerifySMS:(GetVerifySMSParameter *)parameter
{
    [AVOSCloud requestSmsCodeWithPhoneNumber:parameter.phone callback:^(BOOL succeeded, NSError *error) {
        [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
    }];
}

- (void)ValidateVerifyCode:(ValidateVerifyCodeParameter *)paramter
{
    [AVOSCloud verifySmsCode:paramter.verifyCode
           mobilePhoneNumber:paramter.phone
                    callback:^(BOOL succeeded, NSError *error) {
                        [self raiseResponseWithObj:nil error:error andRequestParameter:paramter];
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
    
    if (parameter.avatar) {
        AVFile * avatar = [AVFile fileWithName:@"avatar.jpg" data:parameter.avatar];
        [avatar saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [currentUser setObject:avatar forKey:@"avatar"];
                
                [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
                }];
            }
        }];
    }
    else {
        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
        }];
    }
}

- (void)GetUserInfo:(GetUserInfoParameter *)parameter
{
    AVQuery * q = [AVUser query];
    [q whereKey:@"objectId" equalTo:parameter.userIdentifier];
    [q findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        UserModel * user = nil;
        if (error == nil && objects.count > 0) {
            AVUser * queryResult = objects[0];
            user = [UserModel userFromAVUser:queryResult];
        }
        [self raiseResponseWithObj:user error:error andRequestParameter:parameter];
    }];
}

- (void)SubmitCertificationProfile:(ABCParameter *)parameter
{
}

- (void)GetSuggestActivities:(GetSuggestActivitiesParameter *)parameter
{
    AVQuery * q = [AVQuery queryWithClassName:@"SuggestActivity"];
    [q findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray * activityList = nil;
        if (!error && objects.count > 0) {
            activityList = [NSMutableArray arrayWithCapacity:objects.count];
            [objects enumerateObjectsUsingBlock:^(AVObject * act, NSUInteger idx, BOOL *stop) {
                ActivityModel * model = [[ActivityModel alloc]init];
                model.identifier = act.objectId;
                model.date = [act objectForKey:@"date"];
                model.destination = [act objectForKey:@"destination"];
                model.cost = [act objectForKey:@"cost"];
                model.name = [act objectForKey:@"name"];
                model.posterUrl = [(AVFile *)[act objectForKey:@"poster"] url];
                model.toplimit = [act objectForKey:@"toplimit"];
                [activityList addObject:model];
            }];
        }
        [self raiseResponseWithObj:activityList error:error andRequestParameter:parameter];
    }];
}

- (void)GetUserJoiningActivities:(GetUserJoiningActivitiesParameter *)parameter
{
    AVQuery * queryParticipant = [AVQuery queryWithClassName:NSStringFromClass([ActivityModel class])];
    [queryParticipant whereKey:@"participants" equalTo:[AVUser objectWithoutDataWithObjectId:parameter.userIdentifier]];

    [queryParticipant includeKey:@"owner"];
    [queryParticipant findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray * results = nil;
        if (!error && objects.count > 0) {
            results = [NSMutableArray arrayWithCapacity:objects.count];
            for (AVObject * avobj in objects) {
                ActivityModel * model = [ActivityModel activityFromAVObject:avobj];
                [results addObject:model];
            }
        }
        
        [self raiseResponseWithObj:results error:error andRequestParameter:parameter];
    }];
}

- (void)GetUserOwningActivities:(GetUserOwningActivitiesParameter *)parameter
{
    
    AVQuery * queryOwner = [AVQuery queryWithClassName:NSStringFromClass([ActivityModel class])];
    [queryOwner whereKey:@"owner" equalTo:[AVUser objectWithoutDataWithObjectId:parameter.userIdentifier]];
    
    [queryOwner includeKey:@"owner"];
    [queryOwner findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray * results = nil;
        if (!error && objects.count > 0) {
            results = [NSMutableArray arrayWithCapacity:objects.count];
            for (AVObject * avobj in objects) {
                ActivityModel * model = [ActivityModel activityFromAVObject:avobj];
                [results addObject:model];
            }
        }
        
        [self raiseResponseWithObj:results error:error andRequestParameter:parameter];
    }];
}

- (void)GetActivitiesDetail:(ABCParameter *)parameter
{
    
}

- (void)GetCommentsInActivity:(GetCommentsInActivityParameter *)parameter
{
    AVQuery * q = [AVQuery queryWithClassName:NSStringFromClass([CommentModel class])];
    [q whereKey:@"activity" equalTo:[AVObject objectWithoutDataWithObjectId:parameter.activityIdentifier]];
    [q includeKey:@"user"];
    [q findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray * results = nil;
        if (!error && objects.count > 0) {
            results = [NSMutableArray arrayWithCapacity:objects.count];
            for (AVObject * avobj in objects) {
                [results addObject:[CommentModel commentFromAVObject:avobj]];
            }
            [self raiseResponseWithObj:results error:error andRequestParameter:parameter];
        }
    }];
}

- (void)ReplyActivity:(ReplyActivityParameter *)parameter
{
    AVObject * object = [AVObject objectWithClassName:NSStringFromClass([CommentModel class])];
    [object setObject:[AVObject objectWithoutDataWithObjectId:parameter.activityIdentifier] forKey:@"activity"];
    [object setObject:[AVUser currentUser] forKey:@"user"];
    [object setObject:parameter.content forKey:@"content"];
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
    }];
}

- (void)CreateActivity:(CreateActivityParameter *)parameter
{
    // 先保存图片
    AVFile * poster = [AVFile fileWithName:@"poster.jpg" data:UIImageJPEGRepresentation(parameter.poster, .2)];
    [poster saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        // 保存图片成功之后保存活动数据
        if (succeeded) {
            // 活动基础数据
            AVObject * activity = [AVObject objectWithClassName:NSStringFromClass([ActivityModel class])];
            [parameter.toDic enumerateKeysAndObjectsUsingBlock:^(NSString * key, NSString * obj, BOOL *stop) {
                [activity setObject:obj forKey:key];
            }];
            // 活动图片(已保存为avfile)
            [activity setObject:poster forKey:@"poster"];
            // 发起人信息
            [activity setObject:[AVUser currentUser] forKey:@"owner"];
            __weak typeof(activity) weakRef = activity;
            [activity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                __strong typeof(weakRef) strongRef = weakRef;
                [self raiseResponseWithObj:[ActivityModel activityFromAVObject:strongRef] error:error andRequestParameter:parameter];
            }];
        }
        // 保存图片失败返回失败
        else {
            [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
        }
    }];
}

- (void)InviteUsers:(ABCParameter *)parameter
{
}

- (void)ReplyInvitation:(ReplyInvitationParameter *)parameter
{
    /*
     1接受
     2忽略
     */
    if (parameter.accepted) {
        NSString * activityId = parameter.invitedActivityId;
        
        AVQuery * q = [AVQuery queryWithClassName:NSStringFromClass([ActivityModel class])];
        [q getObjectInBackgroundWithId:activityId block:^(AVObject *object, NSError *error) {
            // 获取对应活动，如果获取失败就发送error
            if (error) {
                [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
                
                return ;
            }
            // 如果获取成功，设置activity的关联用户
            AVRelation * participants = [object relationforKey:@"participants"];
            [participants addObject:[AVUser currentUser]];
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                LOG_EXPR(object);
                [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
            }];
        }];
    }
    else {
        // 忽略活动，不必创建关联，直接返回
        [self raiseResponseWithObj:nil error:nil andRequestParameter:parameter];
    }
}

- (void)ChatToUser:(ABCParameter *)parameter
{
}

- (void)FollowUser:(FollowUserParameter *)parameter
{
    AVUser * current = [AVUser currentUser];
    AVUser * targetUser = [AVUser objectWithoutDataWithClassName:@"_User" objectId:parameter.userIdentifier];
    if (!targetUser) {
        [self raiseResponseWithObj:nil error:[NSError errorWithDomain:@"" code:-1 userInfo:nil] andRequestParameter:parameter];
        return;
    }
    // 获取对方用户成功
    [current follow:parameter.userIdentifier andCallback:^(BOOL succeeded, NSError *error) {
        
        if (!succeeded) {
            [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
        }
        
        // follow操作成功
        [current incrementKey:@"countOfFollowing" byAmount:@(1)];
        [current saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!succeeded) {
                [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
                return ;
            }
            
            // 当前用户countOfFOllowing ＋＋ 成功
            [targetUser incrementKey:@"countOfFollower" byAmount:@(1)];
            [targetUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!succeeded) {
                    [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
                    return ;
                }
                
                // 目标用户countOfFollower＋＋成功
                [self raiseResponseWithObj:nil error:nil andRequestParameter:parameter];
            }];
        }];
    }];
}

- (void)UnfollowUser:(UnfollowUserParameter *)parameter
{
    AVUser * current = [AVUser currentUser];
    AVUser * targetUser = [AVUser objectWithoutDataWithClassName:@"_User" objectId:parameter.userIdentifier];
    if (!targetUser) {
        [self raiseResponseWithObj:nil error:[NSError errorWithDomain:@"" code:-1 userInfo:nil] andRequestParameter:parameter];
        return;
    }
    // 获取对方用户成功
    [current unfollow:parameter.userIdentifier
          andCallback:^(BOOL succeeded, NSError *error) {
              
              if (!succeeded) {
                  [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
              }
              
              // follow操作成功
              [current incrementKey:@"countOfFollowing" byAmount:@(-1)];
              [current saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                  if (!succeeded) {
                      [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
                      return ;
                  }
                  
                  // 当前用户countOfFOllowing －－ 成功
                  [targetUser incrementKey:@"countOfFollower" byAmount:@(-1)];
                  [targetUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                      if (!succeeded) {
                          [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
                          return ;
                      }
                      
                      // 目标用户countOfFollower－－成功
                      [self raiseResponseWithObj:nil error:nil andRequestParameter:parameter];
                  }];
              }];
          }];
}

- (void)GetFollowing:(GetFollowingParameter *)parameter
{
    AVQuery * q = [AVUser followeeQuery:parameter.userIdentifier];
    [q includeKey:@"followee"];
    [q findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray * results = nil;
        if (error == nil && results.count > 0) {
            results = [NSMutableArray array];
            for (AVUser * user in objects) {
                [results addObject:[UserModel userFromAVUser:user]];
            }
        }
        [self raiseResponseWithObj:results error:error andRequestParameter:parameter];
    }];
}

- (void)GetFollowers:(GetFollowersParameter *)parameter
{
    AVQuery * q = [AVUser followerQuery:parameter.userIdentifier];
    [q includeKey:@"follower"];
    [q findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray * results = nil;
        if (error == nil && results.count > 0) {
            results = [NSMutableArray array];
            for (AVUser * user in objects) {
                [results addObject:[UserModel userFromAVUser:user]];
            }
        }
        [self raiseResponseWithObj:results error:error andRequestParameter:parameter];
    }];
}

- (void)GetParticipants:(GetParticipantsParameter *)parameter
{
    AVQuery * q = [AVQuery queryWithClassName:NSStringFromClass([ActivityModel class])];
    [q getObjectInBackgroundWithId:parameter.activityIdentifier block:^(AVObject *object, NSError *error) {
        if (error) {
            [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
            
            return ;
        }
        AVRelation * participants = [object relationforKey:@"participants"];
        AVQuery * participantsQuery = [participants query];
        [participantsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            NSMutableArray * users = nil;
            if (!error && objects.count > 0) {
                users = [NSMutableArray arrayWithCapacity:objects.count];
                for (AVUser * avuser in objects) {
                    UserModel * user = [UserModel userFromAVUser:avuser];
                    [users addObject:user];
                }
            }
            [self raiseResponseWithObj:users error:error andRequestParameter:parameter];
        }];
    }];
}

- (void)UploadPhotos:(ABCParameter *)parameter
{
    
}

@end
