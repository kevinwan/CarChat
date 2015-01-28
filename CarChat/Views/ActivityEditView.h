//
//  ActivityEditView.h
//  CarChat
//
//  Created by 赵佳 on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"
#import <RPFloatingPlaceholderTextView.h>
#import <RPFloatingPlaceholderTextField.h>

@interface ActivityEditView : UIView
@property (weak, nonatomic) IBOutlet RPFloatingPlaceholderTextView *name;
@property (weak, nonatomic) IBOutlet RPFloatingPlaceholderTextField *date;
@property (weak, nonatomic) IBOutlet RPFloatingPlaceholderTextField *destiny;
@property (weak, nonatomic) IBOutlet RPFloatingPlaceholderTextField *toplimit;
@property (weak, nonatomic) IBOutlet UISegmentedControl *payType;
@property (weak, nonatomic) IBOutlet RPFloatingPlaceholderTextField *cost;

+ (instancetype)view;

- (void)layoutWithActivity:(ActivityModel *)activity;

- (void)beginEdit;
@property (nonatomic, copy) UIImage * (^choosePosterBlock)(void);

- (ActivityModel *)generateActivity;

@end
