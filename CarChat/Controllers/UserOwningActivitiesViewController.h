//
//  MyActivitiesViewController.h
//  CarChat
//
//  Created by Develop on 15/1/15.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "AbstractViewController.h"

#warning TODO: 重构这两个列表vc，抽象出父类

@interface UserOwningActivitiesViewController : AbstractViewController

- (instancetype)initWithUserId:(NSString *)userId;

- (void)setTableHeader:(UIView *)header;

@end
