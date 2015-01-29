//
//  ActivityEditView.m
//  CarChat
//
//  Created by 赵佳 on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ActivityEditView.h"
#import <UIImageView+WebCache.h>
#import "NSString+Helpers.h"

@interface ActivityEditView ()
@property (weak, nonatomic) IBOutlet UIImageView *posterView;

/**
 *  用户选择的图片文件。如果用户自己选择了图片，创建model时就用这个。
 */
@property (nonatomic, copy) UIImage * userChoosedPoster;
/**
 *  原始poster图片的地址，如果用户没有选择图片，创建model时就回传原始图片地址。
 */
@property (nonatomic, copy) NSString * originPosterUrl;

@end

@implementation ActivityEditView

#pragma mark - Lifecycle
+ (instancetype)view
{
    ActivityEditView * view = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil  options:nil][0];
    [view setUserInteractionEnabled:NO];
    return view;
}

#pragma mark - Public Apis
- (void)layoutWithActivity:(ActivityModel *)activity
{
    [self.name setPlaceholder:@"活动名称"];
    if (activity.posterImage) {
        UIImage * posterImage = activity.posterImage;
        [self.posterView setImage:posterImage];
        self.userChoosedPoster = posterImage;
        self.originPosterUrl = nil;
    }
    else  {
        [self.posterView sd_setImageWithURL:[NSURL URLWithString:activity.posterUrl]];
        self.originPosterUrl = activity.posterUrl;
        self.userChoosedPoster = nil;
    }
    self.name.text = activity.name;
    self.destiny.text = activity.destination;
    self.date.text = activity.date;
    [self.date setHidden:!activity.date || [activity.date isBlank]];
    self.toplimit.text = activity.toplimit;
    [self.toplimit setHidden:!activity.toplimit || [activity.toplimit isBlank]];
//    [self.payType setSelectedSegmentIndex:activity.payType];
    [self.payType setHidden:activity.payType == 0];
    self.cost.text = activity.cost;
    [self.cost setHidden:!activity.cost || [activity.cost isBlank]];
}

- (void)beginEdit
{
    [UIView animateWithDuration:.2f animations:^{
        [self.date setHidden:NO];
        [self.destiny setHidden:NO];
        [self.toplimit setHidden:NO];
        [self.payType setHidden:NO];
        [self.cost setHidden:NO];
    }];
    [self.name becomeFirstResponder];
}

- (ActivityModel *)generateActivity
{
    ActivityModel * model = [[ActivityModel alloc]init];
    model.name = self.name.text;
    model.destination = self.destiny.text;
    model.date = self.date.text;
    model.toplimit = self.toplimit.text;
    model.payType = self.payType.selectedSegmentIndex + 1;
    model.cost = self.cost.text;
    model.posterImage = self.posterView.image;
    
    return model;
}

#pragma mark - User Interaction
- (IBAction)selectPoster:(id)sender {
    if (self.choosePosterBlock) {
        UIImage * posterImage = self.choosePosterBlock();
        if (posterImage) {
            [self.posterView setImage:posterImage];
            [self.posterView setNeedsDisplay];
        }
    }
}
- (IBAction)choosePayType:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 2) {
        self.cost.text = nil;
        [self.cost setEnabled:NO];
        [self.cost setHidden:YES];
    }
    else {
        [self.cost setEnabled:YES];
        [self.cost setHidden:NO];
    }
}


@end
