//
//  ReplyActivityParameter.h
//  CarChat
//
//  Created by Jia Zhao on 2/1/15.
//  Copyright (c) 2015 GongPingJia. All rights reserved.
//

#import "ABCParameter.h"

@interface ReplyActivityParameter : ABCParameter

@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * activityIdentifier;

@end
