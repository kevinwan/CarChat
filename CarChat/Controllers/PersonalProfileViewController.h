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


// TODO:重构这个类和completePersonalInfoViewCOntroller类，合并功能，复用

@interface PersonalProfileViewController : AbstractViewController

- (instancetype)initWithUserModel:(UserModel *)user;

@end
