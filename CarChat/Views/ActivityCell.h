//
//  SuggestActivityCell.h
//  CarChat
//
//  Created by Develop on 15/1/17.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"

typedef NS_ENUM(NSInteger, ActivityCellStyle) {
    ActivityCellStyleSuggest = 1,   // 推荐活动cell, 用户创建的多了官方icon
    ActivityCellStyleUserCreated    // 用户活动cell
};

extern CGFloat const ActivityCellStyleSuggestHeight;
extern CGFloat const ActivityCellStyleUserCreatedHeight;

@interface ActivityCell : UITableViewCell

- (instancetype)initWithActivityCellStyle:(ActivityCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, readonly) UIImageView * poster;
@property (nonatomic, readonly) UIImageView * ownerAvatar;
@property (nonatomic, readonly) UILabel * name;
@property (nonatomic, readonly) UILabel * period;   // 开始&结束时间
@property (nonatomic, readonly) UILabel * createdDate;  // 活动创建时间

@end
