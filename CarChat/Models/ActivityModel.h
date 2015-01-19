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


@interface ActivityModel : NSObject

@property (nonatomic, strong) NSString * identifier;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * poster;
@property (nonatomic, strong) NSString * destination;
@property (nonatomic, strong) NSString * date;
@property (nonatomic, strong) NSString * toplimit;
@property (nonatomic, assign) PayType payType;
@property (nonatomic, readonly) NSString * payTypeString;
@property (nonatomic, strong) NSString * cost;
@property (nonatomic, strong) UserModel * owner;

- (CreateActivityParameter *)parameter;
+ (instancetype)ActivityWithParameter:(CreateActivityParameter *)parameter;

@end
