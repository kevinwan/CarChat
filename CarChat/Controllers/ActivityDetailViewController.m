//
//  ActivityDetailViewController.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityDescriptionView.h"

@interface ActivityDetailViewController ()

@property (nonatomic, strong) ActivityModel * activity;
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;

@end

@implementation ActivityDetailViewController

#pragma mark - Lifecycle
- (instancetype)initWithActivity:(ActivityModel *)activity
{
    if (self = [super init]) {
        self.activity = activity;
    }
    return self;
}

#pragma mark - View Liftcycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ActivityDescriptionView * header = [ActivityDescriptionView viewFromNib];
    [header layoutWithModel:_activity];
    [self.commentTableView setTableHeaderView:header];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
