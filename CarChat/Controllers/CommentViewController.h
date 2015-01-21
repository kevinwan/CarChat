//
//  CommentViewController.h
//  CarChat
//
//  Created by Develop on 15/1/21.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "AbstractViewController.h"

@interface CommentViewController : AbstractViewController

- (instancetype)initWithActivityId:(NSString *)activityId;

- (void)setListHeaderView:(UIView *)headerView;

@end
