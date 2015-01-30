//
//  ActivityModel+Helper.h
//  CarChat
//
//  Created by Jia Zhao on 1/30/15.
//  Copyright (c) 2015 GongPingJia. All rights reserved.
//

#import "ActivityModel.h"
#import "CreateActivityParameter.h"
#import <AVObject.h>

@interface ActivityModel (Helper)

+ (instancetype)activityFromAVObject:(AVObject *)avobject;

- (CreateActivityParameter *)parameter;
+ (instancetype)ActivityWithParameter:(CreateActivityParameter *)parameter;

@end
