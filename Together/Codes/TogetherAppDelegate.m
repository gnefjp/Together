//
//  AppDelegate.m
//  Together
//
//  Created by Gnef_jp on 13-4-21.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "TogetherAppDelegate.h"

#import "HomeViewController.h"

#import "FileDownloadRequest.h"
#import "KeepSorcket.h"

@implementation TogetherAppDelegate


- (void) _debugNetwork
{
    return;
    int count = 1;
    while (count --)
    {
        FileDownloadRequest* request = [[FileDownloadRequest alloc] init];
        request.fileID = @"2";
        [[NetRequestManager defaultManager] startRequest:request];
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self _debugNetwork];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.viewController = [HomeViewController loadFromNib];
    
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:self.viewController];
    navigationController.navigationBarHidden = YES;
    
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[KeepSorcket defaultManager] connectToHost];
}



@end
