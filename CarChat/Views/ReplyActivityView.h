//
//  ReplyActivityView.h
//  CarChat
//
//  Created by Jia Zhao on 2/1/15.
//  Copyright (c) 2015 GongPingJia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReplyActivityDelegate <NSObject>

- (void)didPressReplyButtonWithContent:(NSString *)content;

- (void)didPressCancelButton;

@end

@interface ReplyActivityView : UIView

- (instancetype)initWithDelegate:(id<ReplyActivityDelegate>)delegate;

- (void)clear;

@end
