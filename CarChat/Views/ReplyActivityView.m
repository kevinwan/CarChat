//
//  ReplyActivityView.m
//  CarChat
//
//  Created by Jia Zhao on 2/1/15.
//  Copyright (c) 2015 GongPingJia. All rights reserved.
//

#import "ReplyActivityView.h"
#import "NSString+Helpers.h"

@interface ReplyActivityView ()

@property (nonatomic, weak) id<ReplyActivityDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation ReplyActivityView

- (instancetype)initWithDelegate:(id<ReplyActivityDelegate>)delegate
{
    ReplyActivityView * v = (ReplyActivityView *)[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    v.delegate = delegate;
    
    return v;
}

- (IBAction)submit:(id)sender
{
    if ([self.contentTextView.text isBlank]) {
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPressReplyButtonWithContent:)]) {
        [self.delegate didPressReplyButtonWithContent:self.contentTextView.text];
    }
}

- (IBAction)dismiss:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPressCancelButton)]) {
        [self.delegate didPressCancelButton];
    }
}

- (void)clear
{
    [self.contentTextView setText:nil];
}

@end
