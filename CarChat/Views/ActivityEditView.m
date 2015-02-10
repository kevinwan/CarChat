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
{
    UIDatePicker * _datePicker;  // 起始时间，结束时间
    UIPickerView * _payPicker;   // 支付类型
}

@property (weak, nonatomic) IBOutlet UIImageView *posterView;


//  用户选择的图片文件。如果用户自己选择了图片，创建model时就用这个。
@property (nonatomic, copy) UIImage * userChoosedPoster;

// 原始poster图片的地址，如果用户没有选择图片，创建model时就回传原始图片地址。
@property (nonatomic, copy) NSString * originPosterUrl;

@end

@implementation ActivityEditView

#pragma mark - Lifecycle
+ (instancetype)view
{
    ActivityEditView * view = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class])
                                                           owner:nil
                                                         options:nil][0];
    [view setupTextFiledsInputView];
    [[NSNotificationCenter defaultCenter] addObserver:view
                                             selector:@selector(checkIfAllFieldTexted)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    return view;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextFieldTextDidChangeNotification
                                                  object:nil];
}

#pragma mark - Public Apis
- (void)layoutWithActivity:(ActivityModel *)activity
{
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
    self.fromDate.text = activity.fromDate;
    self.toDate.text = activity.toDate;
    self.payType.text = activity.payTypeText;
    self.tip.text = activity.notice;
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
    model.fromDate = self.fromDate.text;
    model.toDate = self.toDate.text;
    model.posterImage = self.posterView.image;
    model.payType = [ActivityModel payTypeFromString:self.payType.text];
    model.notice = self.tip.text;
    
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

- (void)datePickerValueChanged:(UIDatePicker *)picker
{
    if ([self.fromDate isFirstResponder]) {
        self.fromDate.text = [NSDateFormatter localizedStringFromDate:[_datePicker date]
                                                            dateStyle:NSDateFormatterShortStyle
                                                            timeStyle:NSDateFormatterNoStyle];
    }
    else if ([self.toDate isFirstResponder]) {
        self.toDate.text = [NSDateFormatter localizedStringFromDate:[_datePicker date]
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterNoStyle];
    }
}

#pragma mark - Internal Helper
- (void)setupTextFiledsInputView
{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0.f, 0.f, 320.f, 200.f)];
        [_datePicker setMinimumDate:[NSDate date]];
        [_datePicker setDatePickerMode:UIDatePickerModeDate];
        [_datePicker addTarget:self
                        action:@selector(datePickerValueChanged:)
              forControlEvents:UIControlEventValueChanged];
    }
    [self.fromDate setInputView:_datePicker];
    [self.toDate setInputView:_datePicker];
    
    if (!_payPicker) {
        _payPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0.f, 0.f, 320.f, 200.f)];
        [_payPicker setDelegate:(id<UIPickerViewDelegate>)self];
        [_payPicker setDataSource:(id<UIPickerViewDataSource>)self];
    }
    [self.payType setInputView:_payPicker];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.fromDate || textField == self.toDate) {
        NSString * startDateText = [NSDateFormatter localizedStringFromDate:[_datePicker date]
                                                                  dateStyle:NSDateFormatterShortStyle
                                                                  timeStyle:NSDateFormatterNoStyle];
        self.fromDate.text = startDateText;
        self.toDate.text = startDateText;
    }
    else if (textField == self.payType) {
        PayType type = PayTypeEverybodyDutch;   // 默认AA
        if (![self.payType.text isBlank]) {
            NSString * payTypeText = self.payType.text;
            type = [ActivityModel payTypeFromString:payTypeText];
            [_payPicker selectRow:type - 1 inComponent:0 animated:NO];
        }
        else {
            self.payType.text = [ActivityModel textFromPayType:type];
        }
        
    }
    else {
        return;
    }
}

#pragma mark - UITextFieldNotification
- (void)checkIfAllFieldTexted
{
    [self willChangeValueForKey:@"isAllFieldFilled"];
    _isAllFieldFilled =
    @(![self.name.text isBlank]
    && ![self.destiny.text isBlank]
    && ![self.fromDate.text isBlank]
    && ![self.toDate.text isBlank]
    && ![self.payType.text isBlank]
    && ![self.tip.text isBlank]);
    [self didChangeValueForKey:@"isAllFieldFilled"];
}

#pragma mark - UIPickerViewDelegate & UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [ActivityModel textFromPayType:row+1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger selected = [_payPicker selectedRowInComponent:0];
    self.payType.text = [ActivityModel textFromPayType:selected + 1];
}

@end
