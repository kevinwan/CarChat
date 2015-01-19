//
//  PersonalInfo.m
//  CarChat
//
//  Created by Develop on 15/1/13.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "PersonalInfoView.h"
#import <UIButton+WebCache.h>
#import "UIView+square2Round.h"

@interface PersonalInfoView ()

@property (nonatomic, assign) PersonalInfoViewStyle style;
@property (weak, nonatomic) IBOutlet UIButton *certifyButton;

@end

@implementation PersonalInfoView

#pragma mark - Lifecycle
+ (instancetype)viewWithStyle:(PersonalInfoViewStyle)style
{
    PersonalInfoView * view = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    view.style = style;
    [view.certifyButton setHidden:style == PersonalInfoViewStyleNormal];
    return view;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.avatarButton makeRoundIfIsSquare];
    
}

#pragma mark - User Interaction
- (IBAction)avatarButtonTapped:(id)sender
{
    [self.avatarButton setBackgroundImage:self.pickBlock() forState:UIControlStateNormal];
}

- (IBAction)certifyButtonTapped:(id)sender {
    self.certifyBlock();
}


#pragma mark - Public Apis
- (void)setUser:(UserModel *)user
{
    if (user) {
        [self.avatarButton sd_setBackgroundImageWithURL:[NSURL URLWithString:user.avatar] forState:UIControlStateNormal];
        self.nickNameField.text = user.nickName;
        NSString * genderStr = @"";
        if (user.gender == GenderMale) {
            genderStr = @"男";
        }
        else if (user.gender == GenderFemale) {
            genderStr = @"女";
        }
        self.genderField.text = genderStr;
        self.ageField.text = user.age;
    }
}

- (void)setEditable:(BOOL)editable
{
    [self.avatarButton setEnabled:editable];
    [self.nickNameField setEnabled:editable];
    [self.genderField setEnabled:editable];
    [self.ageField setEnabled:editable];
}

@end
