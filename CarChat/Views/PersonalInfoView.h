//
//  PersonalInfo.h
//  CarChat
//
//  Created by Develop on 15/1/13.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userModel.h"

typedef NS_ENUM(NSInteger, PersonalInfoViewStyle) {
    PersonalInfoViewStyleNormal = 0,    // 只有头像、昵称、性别、年龄、城市
    PersonalInfoViewStyleAdvance    // 比normal多了上传认证车主功能
};

typedef UIImage * (^AvatarPickerBlock)();
typedef void(^CertifyTouchBlock)(void);

@interface PersonalInfoView : UIView

@property (weak, nonatomic) IBOutlet UIButton *avatarButton;
@property (weak, nonatomic) IBOutlet UITextField *nickNameField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderControl;
@property (weak, nonatomic) IBOutlet UITextField *ageField;
@property (weak, nonatomic) IBOutlet UITextField *cityField;

+ (instancetype)viewWithStyle:(PersonalInfoViewStyle)style;

- (void)setUser:(UserModel *)user;
- (void)setEditable:(BOOL)editable;

@property (nonatomic, copy) AvatarPickerBlock pickBlock;    // 选取头像按钮触发的block
@property (nonatomic, copy) CertifyTouchBlock certifyBlock; // “成为认证车主”按钮触发的block

@end
