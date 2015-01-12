//
//  SuggestedActivityViewController.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "SuggestedActivityViewController.h"
#import "ControllerCoordinator.h"
#import "ActivitiesCollectionDelegator.h"
#import "ActivityModel.h"

static NSString * const activityCellIdentifier = @"activityCellIdentifier";

@interface SuggestedActivityViewController ()
@property (weak, nonatomic) IBOutlet UITableView *suggestionTableView;
@property (nonatomic, strong) NSMutableArray * activities;
@property (nonatomic, strong) ActivitiesCollectionDelegator * tableDelegator;

@end

@implementation SuggestedActivityViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self __createActivitiesForDevelop];
    
    
    self.tableDelegator = [[ActivitiesCollectionDelegator alloc]initWithActivities:self.activities cellIdentifier:activityCellIdentifier];
    [self.tableDelegator setConfigBlock:^(ActivityModel * activity, UITableViewCell * cell) {
        cell.textLabel.text = [NSString stringWithFormat:@"suggestion %@",activity.description];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"date %@",[NSDate date]];
    }];
    __weak typeof(self) weakRef = self;
    [self.tableDelegator setSelectingBlock: ^(ActivityModel * activity) {
        __strong typeof(self) strongRef = weakRef;
        [ControllerCoordinator goNextFrom:strongRef
                                  whitTag:ShowLoginFromSomeWhereTag
                               andContext:nil];
    }];
    [self.suggestionTableView setDataSource:self.tableDelegator];
    [self.suggestionTableView setDelegate:self.tableDelegator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Internal Helper

- (void)__createActivitiesForDevelop
{
    self.activities = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        ActivityModel * activity = [ActivityModel new];
        activity.name = [NSString stringWithFormat:@"name %d",i];
        activity.destination = [NSString stringWithFormat:@"destination %d",i];
        activity.date = [NSString stringWithFormat:@"%@",[NSDate date]];
        activity.amountOfPeople = [NSString stringWithFormat:@"%d",i];
        [self.activities addObject:activity];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
