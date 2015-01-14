//
//  RequestArgument.h
//  CarChat
//
//  Created by 赵佳 on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ABCParameter <NSObject>

@property (nonatomic, strong) NSString * api;
- (NSDictionary *)toDic;

@end

@interface ABCParameter : NSObject <ABCParameter>

+ (instancetype)parameter;

@property (nonatomic, strong) NSString * api;
- (NSDictionary *)toDic;

@end
