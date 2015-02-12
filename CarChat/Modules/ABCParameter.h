//
//  RequestArgument.h
//  CarChat
//
//  Created by 赵佳 on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ABCParameter <NSObject>

@property (nonatomic, strong) id uniqueId;  // 被复用的VC，应该实现设置这个id，来区分不同页面发出的请求
@property (nonatomic, strong) NSString * api;
- (NSDictionary *)toDic;

@end

@interface ABCParameter : NSObject <ABCParameter>

@property (nonatomic, strong) id uniqueId;
@property (nonatomic, strong) NSString * api;
- (NSDictionary *)toDic;
@end
