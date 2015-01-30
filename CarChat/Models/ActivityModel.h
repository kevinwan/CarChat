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
@property (nonatomic, copy) NSString * date;
/**
 *  人数上限
 */
@property (nonatomic, copy) NSString * toplimit;
/**
 *  费用分配
 */
@property (nonatomic, assign) PayType payType;
/**
 *  人均花费
 */
@property (nonatomic, copy) NSString * cost;
/**
 *  创建人信息
 */
@property (nonatomic, strong) UserModel * owner;
/**
 *  邀请码
 */
@property (nonatomic, copy) NSString * invitationCode;


+ (NSString *)stringFromPayType:(PayType)type;
+ (PayType)payTypeFromString:(NSString *)string;

@end
