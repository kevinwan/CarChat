//
//  ActivityInvitator.h
//  CarChat
//
//  Created by Jia Zhao on 2/12/15.
//  Copyright (c) 2015 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityModel.h"

@interface ActivityInvitator : NSObject

- (instancetype)initWithActivity:(ActivityModel *)activity onViewController:(UIViewController *)targetVC;

- (void)show;

@end
