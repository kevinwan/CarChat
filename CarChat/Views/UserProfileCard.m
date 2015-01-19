//
//  MyProfileCard.m
//  CarChat
//
//  Created by Develop on 15/1/19.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UserProfileCard.h"
#import "UIView+square2Round.h"
#import <UIImageView+WebCache.h>

@interface UserProfileCard ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *genderView;
@property (weak, nonatomic) IBOutlet UIImageView *certifyView;
@property (weak, nonatomic) IBOutlet UIButton *activityNumButton;
@property (weak, nonatomic) IBOutlet UIButton *followingNumButton;
@property (weak, nonatomic) IBOutlet UIButton *followerNumButton;

@end

@implementation UserProfileCard

#pragma mark - Lifecycle
+ (instancetype)view
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.avatarView makeRoundIfIsSquare];
    [self.genderView makeRoundIfIsSquare];
    [self.certifyView makeRoundIfIsSquare];
}

#pragma mark - Public Api
- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)layoutWithUser:(UserModel *)user
{
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:user.avatar]];
    self.nameLabel.text = user.nickName;
    self.genderView.image = [user genderImage];
    [self.certifyView setBackgroundColor:[UIColor yellowColor]];
    
    [self.activityNumButton setTitle:user.countOfActvity forState:UIControlStateNormal];
    [self.followingNumButton setTitle:user.countOfFollowing forState:UIControlStateNormal];
    [self.followerNumButton setTitle:user.countOfFollower forState:UIControlStateNormal];
}

#pragma mark - User Interaction
- (IBAction)touchActivity:(id)sender {
    if (self.activityTouched) {
        self.activityTouched();
    }
}

- (IBAction)touchFollowing:(id)sender {
    if (self.followingTouched) {
        self.followingTouched();
    }
}

- (IBAction)touchFollower:(id)sender {
    if (self.followerTouched) {
        self.followerTouched();
    }
}
@end
