//
//  UIView+square2Round.m
//  CarChat
//
//  Created by Develop on 15/1/16.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UIView+square2Round.h"

@implementation UIView (square2Round)

- (void)makeRoundIfIsSquare
{
    if (self.frame.size.height == self.frame.size.width) {
        [self.layer setCornerRadius:self.frame.size.width/2];
        [self.layer setMasksToBounds:YES];
    }
}

@end
