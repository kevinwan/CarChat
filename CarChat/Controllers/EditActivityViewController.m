//
//  EditActivityViewController.m
//  CarChat
//
//  Created by Jia Zhao on 2/8/15.
//  Copyright (c) 2015 GongPingJia. All rights reserved.
//

#import "EditActivityViewController.h"

@interface EditActivityViewController ()

@property (nonatomic, strong) ActivityModel * activity;

@end

@implementation EditActivityViewController

#pragma mark - Lifecycle
- (instancetype)initWithActivity:(ActivityModel *)activity
{
    if (self = [super init]) {
        self.activity = activity;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Lifycycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.activity != nil) {
        self.navigationItem.title = @"创建活动";
    }
    else {
        self.navigationItem.title = @"编辑活动";
    }
    
    
}

@end
