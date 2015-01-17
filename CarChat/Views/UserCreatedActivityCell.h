//
//  ActivityCell.h
//  CarChat
//
//  Created by Develop on 15/1/16.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "ActivityModel.h"

@interface UserCreatedActivityCell : UITableViewCell

@property (readonly, nonatomic)  UIImageView *poster;
@property (readonly, nonatomic)  UILabel *name;
@property (readonly, nonatomic)  UIImageView *createrAvatar;
@property (readonly, nonatomic)  UIImageView *genderIcon;
@property (readonly, nonatomic)  UIImageView *certificatedCarLogo;
@property (readonly, nonatomic)  UILabel *nicknameLabel;

@end

@interface UserCreatedActivityCell (caculate)
+ (CGFloat)heightForActivity:(ActivityModel *)activity;
@end