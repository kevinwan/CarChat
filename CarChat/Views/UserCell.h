//
//  UserCell.h
//  CarChat
//
//  Created by Develop on 15/1/20.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat UserCellHeight;

@interface UserCell : UITableViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, readonly) UIImageView * avatar;
@property (nonatomic, readonly) UILabel * name;
@property (nonatomic, readonly) UIImageView * genderIcon;
@property (nonatomic, readonly) UIImageView * certifyIcon;

@end
