//
//  UserDetailViewController.h
//  CarChat
//
//  Created by Develop on 15/1/22.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "AbstractViewController.h"
#import "UserModel.h"

@interface UserDetailViewController : AbstractViewController

- (instancetype)initWithUserId:(NSString *)userId;

- (UserModel *)user;    // 暴露给外部，用来访问当前detail中展示的user

@end
