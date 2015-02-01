//
//  SuggestActivityCell.m
//  CarChat
//
//  Created by Develop on 15/1/17.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ActivityCell.h"
#import "UIView+square2Round.h"

CGFloat const ActivityCellStyleSuggestHeight = 217.f;
CGFloat const ActivityCellStyleUserCreatedHeight = 298.f;

@interface ActivityCell ()

@property (nonatomic, assign) ActivityCellStyle style;

@end

@implementation ActivityCell

#pragma mark - Lifecycle
- (instancetype)initWithActivityCellStyle:(ActivityCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
        self.style = style;
        
        _poster = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_poster];
        
        _name = [[UILabel alloc]initWithFrame:CGRectZero];
        [_name setFont:[UIFont boldSystemFontOfSize:15]];
        [_name setNumberOfLines:99];
        [_name setBackgroundColor:[UIColor colorWithRed:0.701 green:0.999 blue:1.000 alpha:1.000]];
        [self.contentView addSubview:_name];
        
        if (self.style == ActivityCellStyleUserCreated) {
            
            _cost = [[UILabel alloc]initWithFrame:CGRectZero];
            [_cost setFont:[UIFont systemFontOfSize:14]];
            [_cost setBackgroundColor:[UIColor colorWithRed:0.968 green:1.000 blue:0.750 alpha:1.000]];
            [self.contentView addSubview:_cost];
            
            _toplimit = [[UILabel alloc]initWithFrame:CGRectZero];
            [_toplimit setFont:[UIFont systemFontOfSize:14]];
            [_toplimit setBackgroundColor:[UIColor colorWithRed:1.000 green:0.879 blue:0.851 alpha:1.000]];
            [self.contentView addSubview:_toplimit];
            
            _avatar = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, 50.f, 50.f)];
            [_avatar makeRoundIfIsSquare];
            [self.contentView addSubview:_avatar];
            
            _nickName = [[UILabel alloc]initWithFrame:CGRectZero];
            _nickName.font = [UIFont systemFontOfSize:14.f];
            [_nickName setBackgroundColor:[UIColor colorWithRed:1.000 green:0.773 blue:0.892 alpha:1.000]];
            [self.contentView addSubview:_nickName];
            
            _genderIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, 20.f, 20.f)];
            [_genderIcon makeRoundIfIsSquare];
            [self.contentView addSubview:_genderIcon];
            
            _certifyIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, 20.f, 20.f)];
            [_certifyIcon makeRoundIfIsSquare];
            [self.contentView addSubview:_certifyIcon];
        }
        
        return self;
    }
    return nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize cellSize = self.bounds.size;
    
    [self.poster setFrame:CGRectMake(0.f, 0.f, cellSize.width, 180.f)];
    [self.name setFrame:CGRectMake(0.f, 180.f, cellSize.width, 36.f)];
    if (self.style == ActivityCellStyleUserCreated) {
        [self.cost setFrame:CGRectMake(0.f, 216.f, cellSize.width/2, 16.f)];
        [self.toplimit setFrame:CGRectMake(cellSize.width/2, 216.f, cellSize.width/2, 16.f)];
        [self.avatar setFrame:CGRectMake(8.f, 240.f, 50.f, 50.f)];
        [self.genderIcon setFrame:CGRectMake(66.f, 240.f, 20.f, 20.f)];
        [self.certifyIcon setFrame:CGRectMake(94.f, 240.f, 20.f, 20.f)];
        [self.nickName setFrame:CGRectMake(66.f, 268.f, cellSize.width - 8.f - 66.f, 22.f)];
    }
}

#pragma mark - Public Api

@end
