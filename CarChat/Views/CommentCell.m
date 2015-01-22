//
//  CommentCell.m
//  CarChat
//
//  Created by 赵佳 on 15/1/22.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "CommentCell.h"
#import "UIView+square2Round.h"

const CGFloat cellHeight = 114.f;

@implementation CommentCell

#pragma mark - Lifecycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
        _avatar = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, 50.f, 50.f)];
        [_avatar makeRoundIfIsSquare];
        [self.contentView addSubview:_avatar];
        
        _name = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_name];
        
        _genderIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, 20.f, 20.f)];
        [_genderIcon makeRoundIfIsSquare];
        [self.contentView addSubview:_genderIcon];
        
        _certifyIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, 20.f, 20.f)];
        [_certifyIcon makeRoundIfIsSquare];
        [self.contentView addSubview:_certifyIcon];
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [_contentLabel setBackgroundColor:[UIColor lightGrayColor]];
        [_contentLabel setNumberOfLines:2];
        [_contentLabel setFont:[UIFont systemFontOfSize:12.f]];
        [self.contentView addSubview:_contentLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize cellSize = self.contentView.frame.size;
    
    [self.avatar setFrame:CGRectMake(8.f, 8.f, 50.f, 50.f)];
    [self.genderIcon setFrame:CGRectMake(66.f, 8.f, 20.f, 20.f)];
    [self.certifyIcon setFrame:CGRectMake(94.f, 8.f, 20.f, 20.f)];
    [self.name setFrame:CGRectMake(66.f, 36.f, cellSize.width - 66.f - 8.f, 22.f)];
    [self.contentLabel setFrame:CGRectMake(8.f, 66.f, cellSize.width - 16.f, 32.f)];
}

+ (CGFloat)hegithForComment:(CommentModel *)comment
{
    return cellHeight;
}

@end
