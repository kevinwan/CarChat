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
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.poster = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.poster];
        
        self.name = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.name setFont:[UIFont boldSystemFontOfSize:15.f]];
        [self.name setNumberOfLines:9];
        [self.contentView addSubview:self.name];
        
        self.createrAvatar = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, 50.f, 50.f)];
        [self.contentView addSubview:self.createrAvatar];
        
        self.genderIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, 20.f, 20.f)];
        [self.contentView addSubview:self.genderIcon];
        
        self.certificatedCarLogo = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.certificatedCarLogo];
        
        self.nicknameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.nicknameLabel setFont:[UIFont systemFontOfSize:14.f]];
        [self.contentView addSubview:self.nicknameLabel];
        
        
        [self.createrAvatar makeRoundIfIsSquare];
        [self.genderIcon makeRoundIfIsSquare];
    }
    return self;
}

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
    
    CGFloat cellWidth = self.contentView.bounds.size.width;
    CGFloat cellHeight = self.contentView.bounds.size.height;
    
    [self.poster setFrame:CGRectMake(0.f, 0.f, cellWidth, 180.f)];
    [self.createrAvatar setFrame:CGRectMake(8.f, cellHeight - 58.f, 50.f, 50.f)];
    [self.genderIcon setFrame:CGRectMake(66.f, cellHeight - 58.f, 20.f, 20.f)];
    [self.certificatedCarLogo setFrame:CGRectMake(94.f, cellHeight - 58.f, 20.f, 20.f)];
    [self.nicknameLabel setFrame:CGRectMake(66.f, cellHeight - 30.f, cellWidth - 66.f - 8.f, 22.f)];
    [self.name setFrame:CGRectMake(0.f, 180.f, cellWidth, cellHeight - 180.f - 8.f - 58.f)];
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