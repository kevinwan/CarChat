//
//  CommentCell.h
//  CarChat
//
//  Created by 赵佳 on 15/1/22.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommentCell : UITableViewCell

@property (nonatomic, readonly) UIImageView * avatar;
@property (nonatomic, readonly) UILabel * name;
@property (nonatomic, readonly) UIImageView * genderIcon;
@property (nonatomic, readonly) UIImageView * certifyIcon;
@property (nonatomic, readonly) UILabel * contentLabel;

+ (CGFloat)hegithForComment:(CommentModel *)comment;

@end
