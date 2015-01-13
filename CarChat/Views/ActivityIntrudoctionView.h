//
//  ActivityIntrudoctionView.h
//  CarChat
//
//  Created by 赵佳 on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"

@interface ActivityIntrudoctionView : UIView

+ (instancetype)view;

- (void)layoutWithActivity:(ActivityModel *)activity;

@end
