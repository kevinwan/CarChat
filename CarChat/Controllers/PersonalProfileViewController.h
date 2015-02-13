//
//  PersonalProfileViewController.h
//  CarChat
//
//  Created by 赵佳 on 15/1/19.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractViewController.h"
#import "UserModel.h"

@interface PersonalProfileViewController : AbstractViewController

- (instancetype)initWithUserModel:(UserModel *)user;

@end
