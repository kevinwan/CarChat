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
    [self.posterView sd_setImageWithURL:[NSURL URLWithString:activity.poster]];
    self.name.text = activity.name;
    self.cost.text = activity.cost;
    self.date.text = activity.date;
    self.destiny.text = activity.destination;
    self.toplimit.text = activity.toplimit;
    self.payType.text = activity.payTypeString;
    self.cost.text = activity.cost;
}

- (void)beginEdit
{
    [self.name becomeFirstResponder];
}

- (ActivityModel *)generateActivityAndStoreImageData:(NSData *__autoreleasing *)imageData
{
    ActivityModel * model = [[ActivityModel alloc]init];
    model.name = self.name.text;
//    model.cost = self.costField.text;
//    model.toplimit = self.suggestCountField.text;
    
    *imageData = UIImageJPEGRepresentation(self.posterView.image, .5);
    
    return model;
}

@end
