//
//  ConcreteResponseObject.h
//  CarChat
//
//  Created by Develop on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABCParameter.h"

typedef NSNotification ConcreteResponseObject;

@interface NSNotification (ResponseObject)

@property (nonatomic, readonly) NSString * api;
@property (nonatomic, readonly) id responseObject;
@property (nonatomic, strong) NSError * error;
@property (nonatomic, readonly) ABCParameter * parameter;

+ (instancetype)responseObjectWithApi:(NSString *)api
                               object:(id)object
                  andRequestParameter:(ABCParameter *)parameter;
@end
