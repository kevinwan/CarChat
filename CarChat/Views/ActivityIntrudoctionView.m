//
//  ActivityIntrudoctionView.m
//  CarChat
//
//  Created by 赵佳 on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ActivityIntrudoctionView.h"
#import <UIImageView+WebCache.h>

@interface ActivityIntrudoctionView ()
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *destiny;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *suggestCountLabel;

@end


@implementation ActivityIntrudoctionView

+ (instancetype)view
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
}

- (void)layoutWithActivity:(ActivityModel *)activity
{
    [self.posterView sd_setImageWithURL:[NSURL URLWithString:activity.poster]];
    self.costLabel.text = activity.cost;
    self.nameLabel.text = activity.name;
    self.suggestCountLabel.text = activity.toplimit;
}

@end
