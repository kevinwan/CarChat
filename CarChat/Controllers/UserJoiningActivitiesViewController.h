//
//  UserJoiningActivitiesViewController.h
//  CarChat
//
//  Created by Jia Zhao on 2/12/15.
//  Copyright (c) 2015 GongPingJia. All rights reserved.
//

#import "AbstractViewController.h"

@interface UserJoiningActivitiesViewController : AbstractViewController

- (instancetype)initWithUserId:(NSString *)userId;

- (void)setTableHeader:(UIView *)header;

@end
