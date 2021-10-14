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

RoboGameContainer* gameView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString* fw = @"com.badlogicgames.superjumper.framework";
    NSString* clazz = @"com.badlogicgames.superjumper.framework.SuperJumper";
    
    gameView = [RoboGameContainer newInstance:fw classname:clazz];
    
    self.window.rootViewController = (UIViewController *)gameView;
    [self.window makeKeyAndVisible];
    
    return YES;
}

//- (void)applicationWillEnterForeground:(UIApplication *)application {
//    [gameView viewWillAppear:NO];
//}

//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    [gameView viewDidAppear:NO];
//}

//- (void)applicationWillResignActive:(UIApplication *)application {
//    [gameView viewWillDisappear:NO];
//}


//- (void)applicationWillTerminate:(UIApplication *)application {
//    [gameView viewDidDisappear:NO];
//}

@end
