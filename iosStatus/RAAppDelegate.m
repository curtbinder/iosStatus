//
//  RAAppDelegate.m
//  ReefAngelStatus
//
//  Created by Curt Binder on 10/15/13.
//  Copyright (c) 2013 Curt Binder. All rights reserved.
//

#import "RAAppDelegate.h"

@implementation RAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // Subclass NSDictionary with Default Values for preferences
    // Defaults include the Labels that are not visible currently in the settings bundle
    // Register default preferences here
    NSDictionary *appDefaults = [NSDictionary
                                 dictionaryWithObject:@"2000" forKey:@"port_preference"];
    [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
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
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // TODO figure out how to register for changes using NSUserDefaultsDidChangeNotification
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs synchronize];
    _host = [prefs stringForKey:@"host_preference"];
    _port = [prefs stringForKey:@"port_preference"];
    _username = [prefs stringForKey:@"username_preference"];
//    NSLog(@"Active: H: %@\nP: %@\nU: %@", _host, _port, _username);
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
