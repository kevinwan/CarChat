//
//  ActivityDescriptionView.h
//  CarChat
//
//  Created by Develop on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"

@interface UserCreatActivityDescriptionView : UIView

+ (instancetype)view;

- (void)layoutWithModel:(ActivityModel *)activity;

@property (nonatomic, copy) void (^viewParticipantsBlock)();

@end
