//
//  AppDelegate.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/4/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "AppDelegate.h"
#import "DVVYSignUpViewController.h"
#import "DVYIntroPageViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Parse setApplicationId:@"SSNDa4H9uDAGFxVAMGtKN41TilT6lsB7sD3c3p0I"
                  clientKey:@"FGG2a29BzXoPZlK8cJ4SPIXDSpt0l6Z09MilbwFM"];
    
    [PFFacebookUtils initializeFacebook];

    // Override point for customization after application launch.
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // create an instance of the view controller you want to be displayed first
    DVYIntroPageViewController *introPage = [[DVYIntroPageViewController alloc] initWithNibName:@"DVYIntroPageViewController" bundle:nil];
    
    introPage.view.frame = self.window.frame;
    //self.navController.navigationBarHidden = NO;
    
    self.window.rootViewController = introPage;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
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

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
