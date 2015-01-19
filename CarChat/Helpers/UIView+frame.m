//
//  UIView+frame.m
//  CarChat
//
//  Created by Develop on 15/1/19.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)
- (CGFloat)x
{
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x
{
    [self setFrame:CGRectMake(x, self.y, self.width, self.height)];
}
- (CGFloat)y
{
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y
{
    [self setFrame:CGRectMake(self.x, y, self.width, self.height)];
}
- (CGFloat)width
{
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width
{
    [self setFrame:CGRectMake(self.x, self.y, width, self.height)];
}
- (CGFloat)height
{
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height
{
    [self setFrame:CGRectMake(self.x, self.y, self.width, height)];
}
@end
