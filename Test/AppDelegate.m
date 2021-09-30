//
//  AppDelegate.m
//  Test
//
//  Created by Akash Khunt on 06/08/21.
//

#import "AppDelegate.h"
#import <SuperJumperFramework/SuperJumperFramework.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

IOSGameLauncher* launcher;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    launcher = [IOSGameLauncher instance];
    [launcher didFinishLaunching:application];
    [SuperJumperFrameworkDemo hello];
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [launcher willEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [launcher didBecomeActive:application];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [launcher willResignActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [launcher willTerminate:application];
}

@end
