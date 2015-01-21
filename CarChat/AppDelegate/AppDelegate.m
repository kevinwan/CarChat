//
//  AppDelegate.m
//  CarChat
//
//  Created by Develop on 15/1/9.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "AppDelegate.h"
#import "SuggestedActivityViewController.h"
#import "MyViewController.h"
#import <SCLAlertView.h>
#import "ActivityModel.h"

static const NSInteger SuggestNavItemTag = 1;
static const NSInteger MyNavItemTag = 2;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiGetActivityWithInviteCode];
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UITabBarController * rootTabbar = [[UITabBarController alloc]init];
    // item 1 - suggest
    SuggestedActivityViewController * suggestVC = [[SuggestedActivityViewController alloc]init];
    suggestVC.title = @"推荐";
    suggestVC.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:SuggestNavItemTag];
    
    // item 2 - my
    MyViewController *myVC = [[MyViewController alloc]init];
    myVC.title = @"我的";
    myVC.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemContacts tag:MyNavItemTag];
    [rootTabbar setViewControllers:@[suggestVC, myVC]];
    [rootTabbar setSelectedIndex:0];
    
    UINavigationController * rootNav = [[UINavigationController alloc]initWithRootViewController:rootTabbar];
    [_window setRootViewController:rootNav];

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

#pragma mark - CCNetworkResponse
- (void)didGetResponseNotification:(ConcreteResponseObject *)response
{
    if (response.error) {
        // fail
        // do nothing
    }
    else {
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        [alert addButton:@"查看"
             actionBlock:^(void) {
                 ActivityModel * act = [[ActivityModel alloc]init];
                 act.name = @"栖霞山看枫叶";
                 act.destination = @"栖霞山";
                 act.date = @"2015年2月14日";
                 act.toplimit = @"12";
                 act.cost = @"50$/人";
                 act.poster = @"http://f.hiphotos.baidu.com/image/pic/item/11385343fbf2b2119695ec50c98065380cd78e70.jpg";
                 act.owner.avatar = @"http://f.hiphotos.baidu.com/image/pic/item/fd039245d688d43f5a0f54f37f1ed21b0ef43b09.jpg";
                 act.owner.nickName = @"范爷";
                 act.owner.gender = GenderFemale;
                 
                 [self showInviteWithActivity:act];
             }];
        
        [alert showInfo:((UINavigationController *)_window.rootViewController).viewControllers[0]
                  title:@"收到一个活动邀请"
               subTitle:@"点击查看了解详情"
       closeButtonTitle:@"忽略"
               duration:.0f];
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
