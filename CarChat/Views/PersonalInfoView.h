//
//  PersonalInfo.h
//  CarChat
//
//  Created by Develop on 15/1/13.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userModel.h"

typedef UIImage * (^AvatarPickerBlock)();

@interface PersonalInfoView : UIView

+ (instancetype)view;

- (void)setUser:(UserModel *)user;

- (void)setEditable:(BOOL)editable;

@property (nonatomic, copy) AvatarPickerBlock pickBlock;

@end
