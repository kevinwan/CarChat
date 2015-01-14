//
//  LoginParameter.h
//  CarChat
//
//  Created by 赵佳 on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ABCParameter.h"

@interface LoginParameter : ABCParameter

@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSString * pwd;

- (NSDictionary *)toDic;

@end
