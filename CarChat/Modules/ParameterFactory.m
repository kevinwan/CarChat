//
//  ParameterFactor.m
//  CarChat
//
//  Created by Develop on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ParameterFactory.h"

@implementation ParameterFactory

+ (ABCParameter *)parameterWithApi:(NSString *)api
{
    Class parameterClass = NSClassFromString([NSString stringWithFormat:@"%@Parameter",api]);
    ABCParameter * instance = [[parameterClass alloc]init];
    [instance setApi:api];
    return instance;
}

@end
