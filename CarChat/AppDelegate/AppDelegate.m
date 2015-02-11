//
//  AppDelegate.m
//  CarChat
//
//  Created by Develop on 15/1/9.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "AppDelegate.h"
#import "MainActivitiesViewController.h"
#import "MyViewController.h"
#import <SCLAlertView.h>
#import "ActivityModel.h"
#import "TestViewController.h"
#import "CCStatusManager.h"
#import "UserModel+helper.h"
#import "UIImage+color.h"
#import "WXApi.h"
#import "WXApiObject.h"
// for test
//#import "GetActivityWithInviteCodeParameter.h"
//#import "FollowUserParameter.h"
//#import "UnfollowUserParameter.h"

NSString * const WXAppKey = @"wxe489a68ecb5f378f";

static const NSInteger SuggestNavItemTag = 1;
static const NSInteger MyNavItemTag = 2;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // for AVOS
    [AVOSCloud setApplicationId:@"1x7a2rcepv9k4yrn8qmfq31gk3bqf33c663zkq88c88z9eqr"
                      clientKey:@"yxgmlhkjhs88ulxs3b8gsw54o1mzxl93ya78dqy92lvrhf61"];
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
//    setenv("LOG_CURL", "YES", 0);
    
    // for WeChat
    [WXApi registerApp:WXAppKey withDescription:@"车聊"];
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiGetActivityWithInviteCode];
    
    // build MAIN UI
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UITabBarController * rootTabbar = [[UITabBarController alloc]init];
    [rootTabbar.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    NSDictionary * titleAttr = @{
                                NSFontAttributeName:[UIFont boldSystemFontOfSize:18.f]
                                };
    UIOffset titleOffset = UIOffsetMake(0.f, -12.f);
    // item 1 - suggest
    MainActivitiesViewController * suggestVC = [[MainActivitiesViewController alloc]init];
    suggestVC.title = @"活动";
    suggestVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:suggestVC.title image:nil tag:SuggestNavItemTag];
    [suggestVC.tabBarItem setTitleTextAttributes:titleAttr
                                        forState:UIControlStateNormal];
    [suggestVC.tabBarItem setTitlePositionAdjustment:titleOffset];
    // item 2 - my
    MyViewController *myVC = [[MyViewController alloc]init];
    myVC.title = @"我的";
    myVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:myVC.title image:nil tag:MyNavItemTag];
    [myVC.tabBarItem setTitleTextAttributes:titleAttr
                                   forState:UIControlStateNormal];
    [myVC.tabBarItem setTitlePositionAdjustment:titleOffset];
    [rootTabbar setViewControllers:@[suggestVC, myVC]];
    [rootTabbar setSelectedIndex:0];
    [rootTabbar setDelegate:(id<UITabBarControllerDelegate>)self];
    
    UINavigationController * rootNav = [[UINavigationController alloc]initWithRootViewController:rootTabbar];
    [_window setRootViewController:rootNav];

    // for test
    // 测试对象释放
//    [_window setRootViewController:[[TestViewController alloc]init]];
    // 测试邀请码对应的活动
//    GetActivityWithInviteCodeParameter * p = (GetActivityWithInviteCodeParameter *)[ParameterFactory parameterWithApi:ApiGetActivityWithInviteCode];
//    p.inviteCode = @"be1327";
//    [[CCNetworkManager defaultManager] requestWithParameter:p];
    // 测试关注sb
//    FollowUserParameter * p = (FollowUserParameter *)[ParameterFactory parameterWithApi:ApiFollowUser];
//    [p setUserIdentifier:@"54cf2fdee4b0294adba658ae"];
//    [[CCNetworkManager defaultManager] requestWithParameter:p];

    [_window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiGetActivityWithInviteCode];
    
//    [self saveContext];
}

#pragma mark - WXApiDelegate
-(void) onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        //
        NSString * resultMessage = resp.errCode == 0 ? @"发送成功" : @"发送失败";
        UIAlertView * av = [[UIAlertView alloc]initWithTitle:@"微信" message:resultMessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [av show];
    }
}

#pragma mark - WX method
- (void)sendInviteCodeToWX:(NSString *)code via:(SendingInvitationVia)wxType
{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = kInviteTextContentWithInviteCode(code);
    req.bText = YES;
    if (wxType == SendingInvitationViaWXTimeLine) {
        req.scene = WXSceneTimeline;
    }
    else if (wxType == SendingInvitationViaWXSession) {
        req.scene = WXSceneSession;
    }
    
    [WXApi sendReq:req];
}

#pragma mark - Overwrite For WX
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    LOG_EXPR(application);
    LOG_EXPR(url);
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    LOG_EXPR(application);
    LOG_EXPR(url);
    LOG_EXPR(sourceApplication);
    LOG_EXPR(annotation);
    return  [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - UITabBarControllerDelegate 判断是否登录
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([tabBarController.viewControllers indexOfObject:viewController] != 1) {
        return YES;
    }
    
    // "MY" view controller
    if ([UserModel isLoged]) {
        return YES;
    }
    else {
        [ControllerCoordinator goNextFrom:self.window.rootViewController whitTag:ShowLoginFromSomeWhereTag andContext:nil];
        return NO;
    }
}

#pragma mark - CCNetworkResponse
- (void)didGetResponseNotification:(ConcreteResponseObject *)response
{
    if (response.error) {
        // fail
        // do nothing
    }
    else {
        if (response.parameter.api == ApiGetActivityWithInviteCode) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"查看"
                 actionBlock:^(void) {
                     ActivityModel * inviteIn = response.object;
                     [self showInviteWithActivity:inviteIn];
                 }];
            
            [alert showInfo:((UINavigationController *)_window.rootViewController).viewControllers[0]
                      title:@"收到一个活动邀请"
                   subTitle:@"点击查看了解详情"
           closeButtonTitle:@"忽略"
                   duration:.0f];
        }
    }
}

#pragma mark - Internal Helper

- (void)showInviteWithActivity:(ActivityModel *)activity
{
    [ControllerCoordinator goNextFrom:self.window.rootViewController
                              whitTag:ShowInviteDetailFromSomeWhereTag
                           andContext:activity];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.gongpingjia.CarChat" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CarChat" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CarChat.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
