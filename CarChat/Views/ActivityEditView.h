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
@property (weak, nonatomic) IBOutlet UITextField * name;
@property (weak, nonatomic) IBOutlet UITextField * destiny;
@property (weak, nonatomic) IBOutlet UITextField * fromDate;
@property (weak, nonatomic) IBOutlet UITextField * toDate;
@property (weak, nonatomic) IBOutlet UITextField * payType;
@property (weak, nonatomic) IBOutlet UITextField * tip;

+ (instancetype)view;

- (void)layoutWithActivity:(ActivityModel *)activity;

- (void)beginEdit;

// 在界面点击选择图片时，会调用此block
@property (nonatomic, copy) UIImage * (^choosePosterBlock)(void);

- (ActivityModel *)generateActivity;

@end
