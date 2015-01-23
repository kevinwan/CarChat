//
//  TestViewController.m
//  CarChat
//
//  Created by Develop on 15/1/23.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "TestViewController.h"
#import "MyViewController.h"
#import "UserActivitiesViewController.h"
#import "UserDetailViewController.h"
#import "FollowingViewController.h"
#import "FollowerViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)my:(id)sender {
    MyViewController * my = [[MyViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:my];
    [self presentViewController:nav animated:YES completion:nil];
    
    [my setLeftNavigationBarItem:@"x" target:my andAction:@selector(dismissSelf)];
}
- (IBAction)useractivity:(id)sender {
    UserActivitiesViewController * activity = [[UserActivitiesViewController alloc]initWithUserId:@""];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:activity];
    [self presentViewController:nav animated:YES completion:nil];
    
    [activity setLeftNavigationBarItem:@"x" target:activity andAction:@selector(dismissSelf)];
}
- (IBAction)following:(id)sender {
    FollowingViewController * following = [[FollowingViewController alloc]initWithUserId:@""];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:following];
    [self presentViewController:nav animated:YES completion:nil];
    
    [following setLeftNavigationBarItem:@"x" target:following andAction:@selector(dismissSelf)];
}
- (IBAction)follower:(id)sender {
    FollowerViewController * follower = [[FollowerViewController alloc]initWithUserId:@""];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:follower];
    [self presentViewController:nav animated:YES completion:nil];
    
    [follower setLeftNavigationBarItem:@"x" target:follower andAction:@selector(dismissSelf)];
}
- (IBAction)userDetailVC:(id)sender {
    UserDetailViewController * detail = [[UserDetailViewController alloc]initWithUserId:@""];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:detail];
    [self presentViewController:nav animated:YES completion:nil];
    
    [detail setLeftNavigationBarItem:@"x" target:detail andAction:@selector(dismissSelf)];
}

@end
