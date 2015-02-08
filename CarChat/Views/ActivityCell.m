//
//  SuggestActivityCell.m
//  CarChat
//
//  Created by Develop on 15/1/17.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ActivityCell.h"
#import "UIView+square2Round.h"

CGFloat const ActivityCellStyleSuggestHeight = 233.f;
CGFloat const ActivityCellStyleUserCreatedHeight = ActivityCellStyleSuggestHeight;

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
        
        _ownerAvatar = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, 50.f, 50.f)];
        [_ownerAvatar makeRoundIfIsSquare];
        [self.contentView addSubview:_ownerAvatar];
        
        _period = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_period];
        
        _createdDate = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_createdDate];
        
        
        if (self.style == ActivityCellStyleSuggest) {
            UILabel * offical = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 0.f, 30.f, 18.f)];
            [offical setTextColor:[UIColor purpleColor]];
            [_name addSubview:offical];
            
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
    
    [self.poster setFrame:
     CGRectMake(0.f,
                0.f,
                cellSize.width,
                180.f)];
//    [self.ownerAvatar setCenter:
//     CGPointMake(self.poster.frame.size.width / 2,
//                 self.poster.frame.size.height - self.ownerAvatar.frame.size.height / 2)];
    [self.ownerAvatar setFrame:CGRectMake(135.f, 130.f, 50.f, 50.f)];
    [self.name setFrame:
     CGRectMake(0.f,
                180.f,
                cellSize.width,
                36.f)];
    [self.period setFrame:
     CGRectMake(0.f,
                216.f,
                cellSize.width,
                16.f)];
    [self.createdDate setFrame:
     CGRectMake(220.f,
                216.f,
                100.f,
                16.f)];
}

#pragma mark - Public Api

@end
