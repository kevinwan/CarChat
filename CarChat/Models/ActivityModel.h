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
@interface ActivityModel : NSObject
/**
 *  id
 */
@property (nonatomic, strong) NSString * identifier;
/**
 *  活动名称
 */
@property (nonatomic, strong) NSString * name;
/**
 *  活动图片地址
 */
@property (nonatomic, strong) NSString * poster;
/**
 *  活动图片数据
 */
@property (nonatomic, strong) NSData * posterData;
/**
 *  目的地
 */
@property (nonatomic, strong) NSString * destination;
/**
 *  活动日期
 */
@property (nonatomic, strong) NSString * date;
/**
 *  人数上限
 */
@property (nonatomic, strong) NSString * toplimit;
/**
 *  费用分配
 */
@property (nonatomic, assign) PayType payType;
/**
 *  人均花费
 */
@property (nonatomic, strong) NSString * cost;
/**
 *  创建人信息
 */
@property (nonatomic, strong) UserModel * owner;

- (CreateActivityParameter *)parameter;
+ (instancetype)ActivityWithParameter:(CreateActivityParameter *)parameter;

+ (NSString *)stringFromPayType:(PayType)type;
+ (PayType)payTypeFromString:(NSString *)string;

@end
