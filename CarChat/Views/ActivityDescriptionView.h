//
//  ActivityDescriptionView.h
//  CarChat
//
//  Created by Develop on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"

@interface ActivityDescriptionView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starterAvtar;
@property (weak, nonatomic) IBOutlet UIImageView *starterGender;
@property (weak, nonatomic) IBOutlet UIImageView *starterCertifyIcon;
@property (weak, nonatomic) IBOutlet UILabel *starterName;

+ (instancetype)viewFromNib;

- (void)layoutWithModel:(ActivityModel *)activity;

@end
