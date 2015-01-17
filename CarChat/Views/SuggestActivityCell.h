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

extern CGFloat const SuggestActivityCellDefaultHeight;

@interface SuggestActivityCell : UITableViewCell
@property (nonatomic, readonly) UIImageView * poster;
@property (nonatomic, readonly) UILabel * name;
@property (nonatomic, readonly) UILabel * cost;
@property (nonatomic, readonly) UILabel * peopleCount;
@end
