//
//  CreateActivityParameter.h
//  CarChat
//
//  Created by 赵佳 on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ABCParameter.h"

/**
 *  创建活动接口参数
 */
@interface CreateActivityParameter : ABCParameter

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * destination;
@property (nonatomic, copy) NSString * date;
@property (nonatomic, copy) NSString * toplimit;
@property (nonatomic, assign) PayType payType;
@property (nonatomic, copy) NSString * cost;
@property (nonatomic, retain) UIImage * poster;
@property (nonatomic, copy) NSString * posterUrl;

@end
