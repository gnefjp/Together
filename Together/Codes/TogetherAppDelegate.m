//
//  AppDelegate.m
//  Together
//
//  Created by Gnef_jp on 13-4-21.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "TogetherAppDelegate.h"

#import "HomeViewController.h"

@implementation TogetherAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.viewController = [HomeViewController loadFromNib];
    self.window.rootViewController = self.viewController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


// TEST
- (void)applicationWillResignActive:(UIApplication *)application
{
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
}



@end
