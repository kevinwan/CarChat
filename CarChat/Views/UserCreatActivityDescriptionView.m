//
//  ActivityDescriptionView.m
//  CarChat
//
//  Created by Develop on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UserCreatActivityDescriptionView.h"
#import <UIImageView+WebCache.h>

@interface UserCreatActivityDescriptionView ()

@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starterAvtar;
@property (weak, nonatomic) IBOutlet UIImageView *starterGender;
@property (weak, nonatomic) IBOutlet UIImageView *starterCertifyIcon;
@property (weak, nonatomic) IBOutlet UILabel *starterName;

@end

@implementation UserCreatActivityDescriptionView

+ (instancetype)view
{
    UserCreatActivityDescriptionView * view = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    return view;
}

- (void)setModel:(ActivityModel *)activity
{
#warning relpace image here
//    [self.poster sd_setImageWithURL:[NSURL URLWithString:activity.posterUrl]];
    [self.poster setImage:activity.posterImage];
    [self.nameLabel setText:activity.name];
    [self.starterAvtar sd_setImageWithURL:[NSURL URLWithString:activity.owner.avatarUrl]];
    [self.starterGender setBackgroundColor:[UIColor redColor]];
    [self.starterCertifyIcon setBackgroundColor:[UIColor blueColor]];
    [self.starterName setText: activity.owner.nickName];
}

- (void)setEditable:(BOOL)editable
{
    _editable = editable;
    [self.poster setUserInteractionEnabled:YES];
}

@end
