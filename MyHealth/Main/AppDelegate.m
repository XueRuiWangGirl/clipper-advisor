//
//  AppDelegate.m
//  MyHealth
//
//  Created by imac on 15/10/21.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "ScrollViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//     Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ScrollViewController *ScrollView = [[ScrollViewController alloc]init];
    NSString *keyString = (NSString *)kCFBundleVersionKey;
    //    新版本号
    NSString *valueString = [NSBundle mainBundle].infoDictionary[keyString];
    //    获取本地版本号
    NSString *valueStr = [[NSUserDefaults standardUserDefaults] objectForKey:keyString];
    
    if ([valueString isEqualToString:valueStr]) {
        [self passValue];
    }else{
        self.window.rootViewController = ScrollView;
        [[NSUserDefaults standardUserDefaults] setObject:valueString forKey:keyString];
    }
    

    
    
    
    return YES;
}
- (void)passValue
{
    MainViewController *main_vc = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
    self.nav = [[MainNavigatioController alloc]initWithRootViewController:main_vc];
    self.window.rootViewController = self.nav;

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
