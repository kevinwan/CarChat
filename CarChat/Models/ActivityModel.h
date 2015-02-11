//
//  ActivityModel.h
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "CreateActivityParameter.h"

/**
 *  活动model
 */
@interface ActivityModel : NSObject <NSCopying>
/**
 *  id
 */
@property (nonatomic, copy) NSString * identifier;
/**
 *  活动名称
 */
@property (nonatomic, copy) NSString * name;
/**
 *  活动图片地址
 */
@property (nonatomic, copy) NSString * posterUrl;
/**
 *  活动图片数据
 */
@property (nonatomic, strong) UIImage * posterImage;
/**
 *  目的地
 */
@property (nonatomic, copy) NSString * destination;
/**
 *  活动日期
 */
@property (nonatomic, copy) NSString * fromDate;
@property (nonatomic, copy) NSString * toDate;
/**
 *  人数上限
 */
@property (nonatomic, copy) NSString * toplimit;
/**
 *  费用分配
 */
@property (nonatomic, assign) PayType payType;
@property (nonatomic, readonly) NSString * payTypeText;
/**
 *  人均花费
 */
@property (nonatomic, copy) NSString * cost;
/**
 *  关于活动的通知
 */
@property (nonatomic, copy) NSString * notice;
/**
 *  创建人信息
 */
@property (nonatomic, strong) UserModel * owner;
/**
 *  邀请码
 */
@property (nonatomic, copy) NSString * invitationCode;
/**
 *  活动的参与人数
 */
@property (nonatomic, copy) NSNumber * countOfParticipants;
/**
 *  创建时间
 */
@property (nonatomic, copy) NSString * createDate;
/**
 *  更新时间
 */
@property (nonatomic, copy) NSString * updateDate;


+ (PayType)payTypeFromString:(NSString *)string;
+ (NSString *)textFromPayType:(PayType)type;

@end
