//
//  ActivityCell.m
//  CarChat
//
//  Created by Develop on 15/1/16.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ActivityCell.h"
#import "UIView+square2Round.h"

#define HeightPerLineAtSystemBoldFontSize15 18.f
#define HeightPerLineAtSystemFontSize14 17.f


@implementation ActivityCell

#pragma mark - Lifecycle
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.createrAvatar makeRoundIfIsSquare];
    [self.genderIcon makeRoundIfIsSquare];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat y = self.name.frame.origin.y + self.name.frame.size.height + 8;
    CGRect avatarFrame = self.createrAvatar.frame;
    avatarFrame.origin.y = y;
    [self.createrAvatar setFrame:avatarFrame];
    
    CGRect genderFrame = self.genderIcon.frame;
    genderFrame.origin.y = y;
    [self.genderIcon setFrame:genderFrame];
    
    CGRect carIcon = self.certificatedCarLogo.frame;
    carIcon.origin.y = y;
    [self.certificatedCarLogo setFrame:carIcon];
    
    CGRect nickNameFrame = self.nicknameLabel.frame;
    nickNameFrame.origin.y = y + carIcon.size.height + 8.f;
    [self.nicknameLabel setFrame:nickNameFrame];
}

@end

@implementation ActivityCell (caculate)

+ (CGFloat)heightForActivity:(ActivityModel *)activity
{
    // 计算namelabel的高度
    CGRect newRect = [activity.name boundingRectWithSize:CGSizeMake(320.f, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} context:nil];
    int numOfLines = (newRect.size.height / HeightPerLineAtSystemBoldFontSize15) + 0.5;
    return HeightPerLineAtSystemBoldFontSize15 * (numOfLines - 1) + 265.f;
}

@end