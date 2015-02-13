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
#import "SubmitCertificationProfileParameter.h"
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
// #.LeanCloud用来验证短信验证码的接口
NSString * const ApiValidateVerifyCode = @"ValidateVerifyCode";


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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
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

- (NSString *)randomStringAtLength:(NSInteger)length
{
    char *__r = (char *)malloc(length + 1);
    
    if (__r == 0)
    {
        return nil;
    }
    
    srand(time(NULL) + rand());    //初始化随机数的种子
    
    int i;
    for (i = 0; i  < length; i++)
    {
        int r = 0;
        while (!((r >= 48 && r <= 57)
               || (r >= 65 && r <= 90)
               || (r >= 97 && r <= 122))) {
            r = rand() % 128;
        }
        __r[i] = (char)r;      //控制得到的随机数为可显示字符
    }
    
    __r[i] = 0;
    
    NSString * str = [NSString stringWithUTF8String:__r];
    
    free(__r);
    
    return str;
}

- (NSString *)getUnusedInviteCode
{
    NSString * randomCode = nil;
    AVQuery * query = nil;
    do {
        randomCode = [self randomStringAtLength:6];
        query = [AVQuery queryWithClassName:NSStringFromClass([ActivityModel class])];
        [query whereKey:@"invitationCode" equalTo:randomCode];
    } while ([query countObjects] != 0);
    
    return randomCode;
}

#pragma mark - Concrete Request Methods
- (void)Login:(LoginParameter *)parameter
{
    
    [AVUser logInWithUsernameInBackground:parameter.phone
                                 password:parameter.pwd
                                    block:
     ^(AVUser *user, NSError *error) {
         [user setFetchWhenSave:YES];
         [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
     }
     ];
}

- (void)Register:(RegisterParameter *)parameter
{
    AVUser * user = [AVUser user];
    user.username = parameter.phone;
    user.password = parameter.pwd;
//    user.mobilePhoneNumber = parameter.phone;
    [user setObject:@1 forKey:@"certifyStatus"];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [[AVUser currentUser] setFetchWhenSave:YES];
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
                        
                        [self raiseResponseWithObj:nil
                                             error:error
                               andRequestParameter:paramter];
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
    [q getFirstObjectInBackgroundWithBlock:^(AVObject *object, NSError *error) {
        AVUser * queryResult = (AVUser *)object;
        UserModel * user = [UserModel userFromAVUser:queryResult];
        
        if ([object.objectId isEqualToString:[AVUser currentUser].objectId]) {
            // 是当前用户，就不必查询关系了
            [self raiseResponseWithObj:user error:error andRequestParameter:parameter];
            return ;
        }
        
        if ([AVUser currentUser]) {
            // 如果当前用户已经登陆，查询目标用户与当前用户关系
            AVQuery * q4TargetFollower = [queryResult followerQuery];
            [q4TargetFollower whereKey:@"follower" equalTo:[AVUser currentUser]];
            if ([q4TargetFollower countObjects] > 0) {
                user.relationship = RelationshipFollowing;
            }

        }
        
        [self raiseResponseWithObj:user error:error andRequestParameter:parameter];
    }];
}

- (void)SubmitCertificationProfile:(SubmitCertificationProfileParameter *)parameter
{
    AVFile * photo = [AVFile fileWithName:@"certifyProfile.png" data:UIImagePNGRepresentation(parameter.licenseImage)];
    [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
            return ;
        }
        
        AVUser * current = [AVUser currentUser];
        [current setObject:photo forKey:@"certifiyProfile"];
        [current setObject:@2 forKey:@"certifyStatus"];
        [current setObject:parameter.plateNO forKey:@"plateNO"];
        [current saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
        }];
    }];
}

- (void)GetSuggestActivities:(GetSuggestActivitiesParameter *)parameter
{
    AVQuery * userQuery = [AVUser query];
    [userQuery whereKey:@"userLevel" equalTo:@(UserLevelOfficial)]; // 找到官方用户
    AVQuery * q = [AVQuery queryWithClassName:NSStringFromClass([ActivityModel class])];
    [q whereKey:@"owner" matchesQuery:userQuery];   // 找到官方用户创建的活动
    [q includeKey:@"owner"];
    [q findObjectsInBackgroundWithBlock:
     ^(NSArray *objects, NSError *error) {
         NSMutableArray * activityList = nil;
         if (!error && objects.count > 0) {
             activityList = [NSMutableArray arrayWithCapacity:objects.count];
             [objects enumerateObjectsUsingBlock:
              ^(AVObject * act, NSUInteger idx, BOOL *stop) {
                  ActivityModel * model = [ActivityModel activityFromAVObject:act];
                  [activityList addObject:model];
              }
              ];
         }
         [self raiseResponseWithObj:activityList
                              error:error
                andRequestParameter:parameter];
     }
     ];
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
        }
        [self raiseResponseWithObj:results error:error andRequestParameter:parameter];
    }];
}

- (void)ReplyActivity:(ReplyActivityParameter *)parameter
{
    // 先检查当前用户是否在活动内
    AVObject * activity = [AVQuery getObjectOfClass:NSStringFromClass([ActivityModel class]) objectId:parameter.activityIdentifier];
    AVQuery * query = [activity relationforKey:@"participants"].query;
    [query whereKey:@"objectId" equalTo:[AVUser currentUser].objectId];
    NSArray * users = [query findObjects];
    if (users.count == 0 && ![[(AVUser *)[activity objectForKey:@"owner"] objectId] isEqualToString:[AVUser currentUser].objectId]) {
        [self raiseResponseWithObj:nil error:[NSError errorWithDomain:@"无法评论没有参加的活动" code:-1 userInfo:nil] andRequestParameter:parameter];
        return;
    }
    
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
    // 创建邀请码
    NSString * invitationCode = [self getUnusedInviteCode];
    // 先保存图片
    AVFile * poster = [AVFile fileWithName:@"poster.jpg" data:UIImagePNGRepresentation(parameter.poster)];
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
            // 邀请码
            [activity setObject:invitationCode forKey:@"invitationCode"];
            __weak typeof(activity) weakRef = activity;
            [activity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (!error) {
                    // 用户发起活动数 ＋ 1
                    [[AVUser currentUser] incrementKey:@"countOfOwning" byAmount:@1];
                    [[AVUser currentUser] save];
                }
                
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
            if (error) {
                [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
                return ;
            }
            
            // 验重
            AVRelation * participants = [object relationforKey:@"participants"];
            AVQuery * checkIfReaccept = [participants query];
            [checkIfReaccept whereKey:@"objectId" equalTo:[UserModel currentUserId]];
            if ([checkIfReaccept countObjects] > 0) {
                // 在活动中找到了当前用户，重复加入
                [self raiseResponseWithObj:nil error:[NSError errorWithDomain:@"请勿重复加入" code:-1 userInfo:nil] andRequestParameter:parameter];
                return;
            }
            
            [participants addObject:[AVUser currentUser]];
            [object incrementKey:@"countOfParticipants" byAmount:@1];
            [[AVUser currentUser] incrementKey:@"countOfJoining" byAmount:@1];
            [[AVUser currentUser] save];
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
    AVUser * targetUser = [AVQuery getUserObjectWithId:parameter.userIdentifier];
    if (!targetUser) {
        [self raiseResponseWithObj:nil error:[NSError errorWithDomain:@"" code:-1 userInfo:nil] andRequestParameter:parameter];
        return;
    }
    // 获取对方用户成功
    [current follow:parameter.userIdentifier andCallback:^(BOOL succeeded, NSError *error) {
        
        if (!succeeded) {
            [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
            return ;
        }
        
        // follow操作成功
        [current incrementKey:@"countOfFollowing" byAmount:@(1)];
        [current saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//            if (!succeeded) {
                [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
//                return ;
//            }
            
            // 当前用户countOfFOllowing ＋＋ 成功
            // 再对目标用户的countOfFollower ＋＋ 操作
            // 目标客户countOfFollower＋＋操作有些问题，并且暂时用不到，注释掉
//            [targetUser incrementKey:@"countOfFollower" byAmount:@(1)];
//            [targetUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                if (!succeeded) {
//                    [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
//                    return ;
//                }
//                
//                // 目标用户countOfFollower＋＋成功
//                [self raiseResponseWithObj:nil error:nil andRequestParameter:parameter];
//            }];
        }];
    }];
}

- (void)UnfollowUser:(UnfollowUserParameter *)parameter
{
    AVUser * current = [AVUser currentUser];
    AVUser * targetUser = [AVQuery getUserObjectWithId:parameter.userIdentifier];
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
              
              // unfollow操作成功
              [current incrementKey:@"countOfFollowing" byAmount:@(-1)];
              [current saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                  if (!succeeded) {
                  [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
//                      return ;
//                  }
                  
                  // 当前用户countOfFOllowing －－ 成功
                  // 暂时不需要对目标用户做－－操作，也无法做到
//                  [targetUser incrementKey:@"countOfFollower" byAmount:@(-1)];
//                  [targetUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                      if (!succeeded) {
//                          [self raiseResponseWithObj:nil error:error andRequestParameter:parameter];
//                          return ;
//                      }
//                      
//                      // 目标用户countOfFollower－－成功
//                      [self raiseResponseWithObj:nil error:nil andRequestParameter:parameter];
//                  }];
              }];
          }];
}

- (void)GetFollowing:(GetFollowingParameter *)parameter
{
    AVQuery * q = [AVUser followeeQuery:parameter.userIdentifier];
    [q includeKey:@"followee"];
    [q findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray * results = nil;
        if (error == nil && objects.count > 0) {
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
        if (error == nil && objects.count > 0) {
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
    AVObject * activity = [AVQuery getObjectOfClass:NSStringFromClass([ActivityModel class]) objectId:parameter.activityIdentifier];
    
    AVRelation * participants = [activity relationforKey:@"participants"];
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
}

- (void)UploadPhotos:(ABCParameter *)parameter
{
    
}

@end
