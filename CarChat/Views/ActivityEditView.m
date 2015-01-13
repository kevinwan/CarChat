//
//  ActivityEditView.m
//  CarChat
//
//  Created by 赵佳 on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ActivityEditView.h"
#import <UIImageView+WebCache.h>

@interface ActivityEditView ()
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UITextView *nameField;
@property (weak, nonatomic) IBOutlet UITextView *costField;
@property (weak, nonatomic) IBOutlet UITextView *suggestCountField;

@end

@implementation ActivityEditView

+ (instancetype)viewWithActivity:(ActivityModel *)activity
{
    ActivityEditView * view = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil  options:nil][0];
    [view.posterView sd_setImageWithURL:[NSURL URLWithString:activity.posterUrlStr]];
    view.nameField.text = activity.name;
    view.costField.text = activity.cost;
    view.suggestCountField.text = activity.amountOfPeople;
    
    return view;
}

- (ActivityModel *)generateActivityAndStoreImageData:(NSData *__autoreleasing *)imageData
{
    ActivityModel * model = [[ActivityModel alloc]init];
    model.name = self.nameField.text;
    model.cost = self.costField.text;
    model.amountOfPeople = self.suggestCountField.text;
    
    *imageData = UIImageJPEGRepresentation(self.posterView.image, .5);
    
    return model;
}

@end
