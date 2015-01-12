//
//  ActivityDescriptionView.m
//  CarChat
//
//  Created by Develop on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ActivityDescriptionView.h"
#import <UIImageView+WebCache.h>

@implementation ActivityDescriptionView

+ (instancetype)viewFromNib
{
    id view = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    return (ActivityDescriptionView *)view;
}

- (void)layoutWithModel:(ActivityModel *)activity
{
    [self.poster sd_setImageWithURL:[NSURL URLWithString:activity.posterUrlStr]];
    [self.nameLabel setText:activity.name];
    [self.starterAvtar sd_setImageWithURL:[NSURL URLWithString:activity.starterAvtar]];
    [self.starterGender setBackgroundColor:[UIColor redColor]];
    [self.starterCertifyIcon setBackgroundColor:[UIColor blueColor]];
    [self.starterName setText: activity.starterName];
}

@end
