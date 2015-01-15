//
//  MyViewController.m
//  CarChat
//
//  Created by Develop on 15/1/15.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation MyViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我的";
    
    // Hack the edgeLayout
    [self.myTableView setContentInset:UIEdgeInsetsMake(64.f, 0, 0, 0)];
    
    // hack the empty cell
    [self.myTableView setTableFooterView:[UIView new]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"myCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [self configCelleAtIndexPath:indexPath cell:cell];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [ControllerCoordinator goNextFrom:self
                                      whitTag:MyActivityCellTag
                                   andContext:nil];
        }
            break;
        case 1:
        {
            [ControllerCoordinator goNextFrom:self
                                      whitTag:MyFollowingCellTag
                                   andContext:nil];
        }
            break;
        case 2:
        {
            [ControllerCoordinator goNextFrom:self
                                      whitTag:MyFollowerCellTag
                                   andContext:nil];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Internal Helper
- (void)configCelleAtIndexPath:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell
{
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"我的活动";
            break;
        case 1:
            cell.textLabel.text = @"Following";
            break;
        case 2:
            cell.textLabel.text = @"Follower";
            break;
        default:
            break;
    }
}

@end
