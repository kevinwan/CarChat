//
//  SuggestActivityCell.h
//  CarChat
//
//  Created by Develop on 15/1/17.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "ActivityModel.h"

typedef NS_ENUM(NSInteger, ActivityCellStyle) {
    ActivityCellStyleSuggest = 1,   // 推荐活动cell，包含poster、name、cost、toplimit
    ActivityCellStyleUserCreated    // 用户活动cell，除了推荐活动的cell元素之外，还有avatar,nickName,genderIcon,certifyIcon
};

extern CGFloat const ActivityCellStyleSuggestHeight;
extern CGFloat const ActivityCellStyleUserCreatedHeight;

@interface ActivityCell : UITableViewCell

- (instancetype)initWithActivityCellStyle:(ActivityCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, readonly) UIImageView * poster;
@property (nonatomic, readonly) UILabel * name;
@property (nonatomic, readonly) UILabel * cost;
@property (nonatomic, readonly) UILabel * toplimit;

@property (nonatomic, readonly) UIImageView * avatar;
@property (nonatomic, readonly) UILabel * nickName;
@property (nonatomic, readonly) UIImageView * genderIcon;
@property (nonatomic, readonly) UIImageView * certifyIcon;
@end
