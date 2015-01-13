//
//  ServerPolicyViewController.m
//  CarChat
//
//  Created by Develop on 15/1/13.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ServerPolicyViewController.h"

@interface ServerPolicyViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ServerPolicyViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"服务条款";
    [self setLeftNavigationBarItem:@"关闭" target:self andAction:@selector(dismissSelf)];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.gongpingjia.com"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
