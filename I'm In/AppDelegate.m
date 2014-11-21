//
//  AppDelegate.m
//  I'm In
//
//  Created by Sam Wong on 17/11/2014.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"

#import "ProfileTabViewController.h"
#import "ActivityTabViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//    NSString *authToken = [[NSUserDefaults standardUserDefaults] objectForKey:authToken];
//    if (!authToken) {
//        MenuViewController *menuVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"MENU_VC"];
//        [self presentViewController:menuVC animated:true completion:nil];
//    } else {
//        // set authtoken
//        NSLog(@"auth token set!");
//    }
    
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    
//    UITabBarController *tabController = [[UITabBarController alloc] init];
//    
//    ProfileTabViewController *profileViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
//    
//    ActivityTabViewController *activityViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"ActivityViewController"];
//    
//    profileViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:nil tag:101];
//    activityViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Activity" image:nil tag:102];
//    
//    UINavigationController *profileNavController = [[UINavigationController alloc] initWithRootViewController:profileViewController];
//    
//    tabController.viewControllers = @[activityViewController, profileNavController];
//    
//    [self.window addSubview:tabController.view];
//    
//    self.window.rootViewController = tabController;
//    [self.window makeKeyAndVisible];
    
//    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Profile" image:nil tag:101];
//    UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
//    
//    [tabController.tabBar setItems:@[item]];
    
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
}

@end
