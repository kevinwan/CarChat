//
//  CCNetworkManager.h
//  CarChat
//
//  Created by 赵佳 on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCNetworkResponse.h"
#import "ABCParameter.h"


/**
 *  登录api
 */
extern NSString * const ApiLogin ;
/**
 *  注册api
 */
extern NSString * const ApiRegister ;
/**
 *  验证邀请码
 */
extern NSString * const ApiValidateInviteCode ;
/**
 *  重置密码
 */
extern NSString * const ApiResetPassword ;
/**
 *  获取验证码
 */
extern NSString * const ApiGetVerifySMS ;
/**
 *  设置个人信息
 */
extern NSString * const ApiSetPersonalInfo ;
/**
 *  获取用户信息
 */
extern NSString * const ApiGetUserInfo ;
/**
 *  提交认证车主信息
 */
extern NSString * const ApiSubmitCertificationProfile ;
/**
 *  获取推荐活动列表
 */
extern NSString * const ApiGetSuggestActivities ;
/**
 *  获取我的活动列表
 */
extern NSString * const ApiGetMyActivities ;
/**
 *  获取活动详情
 */
extern NSString * const ApiGetActivitiesDetail ;
/**
 *  获取活动评论
 */
extern NSString * const ApiGetCommentsInActivity ;
/**
 *  评论活动
 */
extern NSString * const ApiReplyActivity ;
/**
 *  创建活动
 */
extern NSString * const ApiCreateActivity ;
/**
 *  根据活动创建邀请码
 */
extern NSString * const ApiCreateInviteCode ;
/**
 *  邀请用户
 */
extern NSString * const ApiInviteUsers ;
/**
 *  发起聊天
 */
extern NSString * const ApiChatToUser ;
/**
 *  关注某人
 */
extern NSString * const ApiFollowUser ;
/**
 *  取关
 */
extern NSString * const ApiUnfollowUser ;
/**
 *  获取我关注人列表
 */
extern NSString * const ApiGetFollowing ;
/**
 *  获取关注我的人列表
 */
extern NSString * const ApiGetFollowers ;


@interface CCNetworkManager : NSObject

+ (instancetype)defaultManager;

/**
 *  添加请求回调对象，必须实现CCNetworkResponse协议中的回调方法
 *
 *  @param observer 回调接受对象
 *  @param api      调用的网络请求Api
 */
- (void)addObserver:(NSObject<CCNetworkResponse> * )observer
             forApi:(NSString *)api;
/**
 *  移除请求回调对象
 *
 *  @param observer 回调接受对象
 *  @param api      调用的网络请求Api
 *  @see -(void)addObserver:forApi
 */
- (void)removeObserver:(NSObject *)observer
                forApi:(NSString *)api;

- (void)requestWithParameter:(ABCParameter *)parameter;

@end


/**
 *  回调Notification中的UserInfo对应parameter的key
 */
extern const NSString * const ResponseUserInfoParameterKey;
