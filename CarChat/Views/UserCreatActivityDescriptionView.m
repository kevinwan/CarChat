//
//  ActivityDescriptionView.m
//  CarChat
//
//  Created by Develop on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UserCreatActivityDescriptionView.h"
#import <UIImageView+WebCache.h>
#import "UIView+square2Round.h"
#import "UserModel+helper.h"

@interface UserCreatActivityDescriptionView ()

@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starterAvtar;
@property (weak, nonatomic) IBOutlet UIImageView *starterGender;
@property (weak, nonatomic) IBOutlet UIImageView *starterCertifyIcon;
@property (weak, nonatomic) IBOutlet UILabel *starterName;

@property (weak, nonatomic) IBOutlet UILabel *countOfParticipants;
@property (weak, nonatomic) IBOutlet UILabel *fromDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *toDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinyLabel;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;

@end

@implementation UserCreatActivityDescriptionView

+ (instancetype)view
{
    UserCreatActivityDescriptionView * view = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    [view.starterAvtar makeRoundIfIsSquare];
    return view;
}

- (void)layoutWithModel:(ActivityModel *)activity
{
    [self.poster sd_setImageWithURL:[NSURL URLWithString:activity.posterUrl]];
    [self.nameLabel setText:activity.name];
    [self.starterAvtar sd_setImageWithURL:[NSURL URLWithString:activity.owner.avatarUrl]];
    [self.starterGender setImage:[activity.owner genderImage]];
    [self.starterCertifyIcon setImage:activity.owner.certifyStatusImage];
    [self.starterName setText: activity.owner.nickName];
    [self.countOfParticipants setText:[NSString stringWithFormat:@"%lu 人",[activity.countOfParticipants unsignedLongValue]]];
    [self.fromDateLabel setText:activity.fromDate];
    [self.toDateLabel setText:activity.toDate];
    [self.destinyLabel setText:activity.destination];
    [self.payLabel setText:activity.payTypeText];
    [self.noticeLabel setText:activity.notice];
}

#pragma mark - User Interaction
- (IBAction)viewParticipantsTapped:(id)sender {
    if (self.viewParticipantsBlock) {
        self.viewParticipantsBlock();
    }
}

@end
