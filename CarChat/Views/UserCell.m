//
//  UserCell.m
//  CarChat
//
//  Created by Develop on 15/1/20.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UserCell.h"
#import "UIView+square2Round.h"

const CGFloat UserCellHeight = 66.f;

@implementation UserCell

#pragma mark - Lifecycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
        _avatar = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, 50.f, 50.f)];
        [_avatar makeRoundIfIsSquare];
        [self.contentView addSubview:_avatar];
        
        _name = [[UILabel alloc]initWithFrame:CGRectZero];
        [_name setFont:[UIFont systemFontOfSize:14.f]];
        [self.contentView addSubview:_name];
        
        _genderIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, 20.f, 20.f)];
        [_genderIcon makeRoundIfIsSquare];
        [self.contentView addSubview:_genderIcon];
        
        _certifyIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, 40.f, 20.f)];
        [_certifyIcon setContentMode:UIViewContentModeCenter];
        [self.contentView addSubview:_certifyIcon];
        
        return self;
    }
    return nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize cellSize = self.contentView.frame.size;
    
    [self.avatar setFrame:CGRectMake(8.f, 8.f, 50.f, 50.f)];
    [self.genderIcon setFrame:CGRectMake(66.f, 8.f, 20.f, 20.f)];
    [self.certifyIcon setFrame:CGRectMake(94.f, 8.f, 40.f, 20.f)];
    [self.name setFrame:CGRectMake(66.f, 36.f, cellSize.width - 66.f - 8.f, cellSize.height - 44.f)];
}

@end
