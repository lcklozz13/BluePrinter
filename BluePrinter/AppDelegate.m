//
//  AppDelegate.m
//  BluePrinter
//
//  Created by baidu on 15/10/26.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "AppDelegate.h"
#import "SQLiteManager.h"
#import "PayPalMobile.h"
#import "ShareManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    m_appDelegate = self;
    
    [SHARE_MANAGER initialization];
    
    [self.window setRootViewController:[[ViewControllerManager getInstance] getRootViewController]];
    
    SQLITE_MANAGER;
    
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"AbY1Crt7jy8kP6v7TYS0K8QLOKgdrdFqrfu9fU0K344DoGAivadT_HKTY3CRGlJ_a-U6SgAy3IPlrlQ0",PayPalEnvironmentSandbox : @"AbpwRfb5QulILjF_vwv0Q3dX8Gw-EbbEZ8Q6c4ckpU6gcFm_OH_yqYAFZN1ei942izwQZbBoe_51wc5M"}];
    
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
    [DATA_MANAGER autoLogin];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
