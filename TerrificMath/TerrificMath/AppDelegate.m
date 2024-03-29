//
//  AppDelegate.m
//  TerrificMath
//
//  Created by Hoang Le on 4/5/14.
//  Copyright (c) 2014 hoang. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"
#import "Appirater.h"

@implementation AppDelegate

- (void)initData
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kHighestPoint] == nil)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kHighestPoint];
    }

    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self initData];
    
    [[GameKitHelper sharedGameKitHelper]
     authenticateLocalPlayer];
    
    MenuViewController *nextVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    self.window.rootViewController = nextVC;
    [self.window makeKeyAndVisible];
    [Appirater appLaunched:YES];
    [Appirater setAppId:@"862863452"];
    [Appirater setDaysUntilPrompt:-1];
    [Appirater setUsesUntilPrompt:2];
    [Appirater setDebug:NO];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [Appirater appEnteredForeground:YES];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
