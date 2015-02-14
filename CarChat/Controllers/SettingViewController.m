//
//  SettingViewController.m
//  CarChat
//
//  Created by Jia Zhao on 2/13/15.
//  Copyright (c) 2015 GongPingJia. All rights reserved.
//

#import "SettingViewController.h"
#import "UserModel+helper.h"
#import "AppDelegate.h"

@interface SettingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray * settingItems;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"设置";
    
    self.settingItems = @[@"退出登录"]; //@"清理缓存", @"打分鼓励", @"关于我们", @"版本介绍", @"当前版本",
    
    UITableView * table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [table setDelegate:self];
    [table setDataSource:self];
    [table setTableFooterView:[UIView new]];
    [self.view addSubview:table];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.settingItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"settingCellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.settingItems[indexPath.row];
    
    if ([self.settingItems[indexPath.row] isEqualToString:@"退出登录"]) {
        cell.textLabel.textColor = [UIColor colorWithRed:1.000 green:0.423 blue:0.396 alpha:1.000];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
//        case 1:
//        case 2:
//        case 3:
//        case 4:
//            [self showTip:@"敬请期待"];
//            break;
//        case 5:
        {
            [UserModel logoutCurrentUser];
            
            AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            
            UINavigationController * rootNav = (UINavigationController *)delegate.window.rootViewController;
            [ControllerCoordinator goNextFrom:rootNav whitTag:ShowLoginFromSomeWhereTag andContext:nil];
            
            UITabBarController * rootTabOfNav = (UITabBarController *)rootNav.viewControllers[0];
            [rootTabOfNav setSelectedIndex:0];
            
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
            break;
        default:
            break;
    }
}

@end
