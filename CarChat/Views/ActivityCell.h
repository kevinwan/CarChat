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

@interface ActivityCell : UITableViewCell

@property (strong, nonatomic)  UIImageView *poster;
@property (strong, nonatomic)  UILabel *name;
@property (strong, nonatomic)  UIImageView *createrAvatar;
@property (strong, nonatomic)  UIImageView *genderIcon;
@property (strong, nonatomic)  UIImageView *certificatedCarLogo;
@property (strong, nonatomic)  UILabel *nicknameLabel;

@end

@interface ActivityCell (caculate)
+ (CGFloat)heightForActivity:(ActivityModel *)activity;
@end