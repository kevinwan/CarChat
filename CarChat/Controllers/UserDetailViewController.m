//
//  UserDetailViewController.m
//  CarChat
//
//  Created by Develop on 15/1/22.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UserDetailViewController.h"
#import "UserModel.h"

@interface UserDetailViewController ()

@property (nonatomic, copy) NSString * userId;

@end

@implementation UserDetailViewController

#pragma mark - Lifecycle
- (instancetype)initWithUserId:(NSString *)userId
{
    if (self = [super init]) {
        self.userId = userId;
    }
    return self;
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
