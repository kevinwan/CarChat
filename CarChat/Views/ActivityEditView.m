//
//  ActivityEditView.m
//  CarChat
//
//  Created by 赵佳 on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ActivityEditView.h"
#import <UIImageView+WebCache.h>
#import <RPFloatingPlaceholderTextView.h>
#import <RPFloatingPlaceholderTextField.h>

@interface ActivityEditView ()
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet RPFloatingPlaceholderTextView *name;
@property (weak, nonatomic) IBOutlet RPFloatingPlaceholderTextField *date;
@property (weak, nonatomic) IBOutlet RPFloatingPlaceholderTextField *destiny;
@property (weak, nonatomic) IBOutlet RPFloatingPlaceholderTextField *toplimit;
@property (weak, nonatomic) IBOutlet RPFloatingPlaceholderTextField *payType;
@property (weak, nonatomic) IBOutlet RPFloatingPlaceholderTextField *cost;

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
    if (activity.posterData) {
        UIImage * posterImage = [UIImage imageWithData:activity.posterData];
        [self.posterView setImage:posterImage];
        self.userChoosedPoster = posterImage;
        self.originPosterUrl = nil;
    }
    else  {
        [self.posterView sd_setImageWithURL:[NSURL URLWithString:activity.poster]];
        self.originPosterUrl = activity.poster;
        self.userChoosedPoster = nil;
    }
    self.name.text = activity.name;
    self.cost.text = activity.cost;
    self.date.text = activity.date;
    self.destiny.text = activity.destination;
    self.toplimit.text = activity.toplimit;
    self.payType.text = [ActivityModel stringFromPayType:activity.payType];
    self.cost.text = activity.cost;
}

- (void)beginEdit
{
    [self.name becomeFirstResponder];
}

- (ActivityModel *)generateActivity
{
    ActivityModel * model = [[ActivityModel alloc]init];
    model.name = self.name.text;
    model.destination = self.destiny.text;
    model.date = self.date.text;
    model.toplimit = self.toplimit.text;
    model.payType = [ActivityModel payTypeFromString:self.payType.text];
    model.cost = self.cost.text;
    if (self.userChoosedPoster != nil) {
        model.posterData = UIImageJPEGRepresentation(self.userChoosedPoster, .5);
    }
    else {
        model.poster = self.originPosterUrl;
    }
    
    return model;
}

@end
