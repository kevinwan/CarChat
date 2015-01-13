//
//  ActivityDescriptionView.m
//  CarChat
//
//  Created by Develop on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ActivityDescriptionView.h"
#import <UIImageView+WebCache.h>

@interface ActivityDescriptionView ()

@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starterAvtar;
@property (weak, nonatomic) IBOutlet UIImageView *starterGender;
@property (weak, nonatomic) IBOutlet UIImageView *starterCertifyIcon;
@property (weak, nonatomic) IBOutlet UILabel *starterName;

@end

@implementation ActivityDescriptionView

+ (instancetype)view
{
    ActivityDescriptionView * view = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    return view;
}

- (void)setModel:(ActivityModel *)activity
{
    [self.poster sd_setImageWithURL:[NSURL URLWithString:activity.posterUrlStr]];
    [self.nameLabel setText:activity.name];
    [self.starterAvtar sd_setImageWithURL:[NSURL URLWithString:activity.starterAvtar]];
    [self.starterGender setBackgroundColor:[UIColor redColor]];
    [self.starterCertifyIcon setBackgroundColor:[UIColor blueColor]];
    [self.starterName setText: activity.starterName];
}

@end
