//
//  SuggestActivityCell.m
//  CarChat
//
//  Created by Develop on 15/1/17.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "SuggestActivityCell.h"

CGFloat const SuggestActivityCellDefaultHeight = 220.f;

@implementation SuggestActivityCell

#pragma mark - Lifecycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _poster = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_poster];
        
        _name = [[UILabel alloc]initWithFrame:CGRectZero];
        [_name setFont:[UIFont boldSystemFontOfSize:15]];
        [_name setBackgroundColor:[UIColor colorWithRed:0.701 green:0.999 blue:1.000 alpha:1.000]];
        [self.contentView addSubview:_name];
        
        _cost = [[UILabel alloc]initWithFrame:CGRectZero];
        [_cost setFont:[UIFont systemFontOfSize:14]];
        [_cost setBackgroundColor:[UIColor colorWithRed:0.968 green:1.000 blue:0.750 alpha:1.000]];
        [self.contentView addSubview:_cost];
        
        _peopleCount = [[UILabel alloc]initWithFrame:CGRectZero];
        [_peopleCount setFont:[UIFont systemFontOfSize:14]];
        [_peopleCount setBackgroundColor:[UIColor colorWithRed:1.000 green:0.879 blue:0.851 alpha:1.000]];
        [self.contentView addSubview:_peopleCount];
        
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
    [self.name setFrame:CGRectMake(0.f, 180.f, cellSize.width, 18.f)];
    [self.cost setFrame:CGRectMake(0.f, 198.f, cellSize.width/2, 16.f)];
    [self.peopleCount setFrame:CGRectMake(cellSize.width/2, 198.f, cellSize.width/2, 16.f)];
}

@end
