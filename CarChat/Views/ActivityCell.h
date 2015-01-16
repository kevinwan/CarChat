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

@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *createrAvatar;
@property (weak, nonatomic) IBOutlet UIImageView *genderIcon;
@property (weak, nonatomic) IBOutlet UIImageView *certificatedCarLogo;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;

@end

@interface ActivityCell (caculate)
+ (CGFloat)heightForActivity:(ActivityModel *)activity;
@end