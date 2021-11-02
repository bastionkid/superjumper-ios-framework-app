//
//  AppDelegate.m
//  Test
//
//  Created by Akash Khunt on 06/08/21.
//

#import "AppDelegate.h"
#import <Poker/game_launcher.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString* clazz = @"com.mega.games.poker.core.Poker";
    NSString* fw = @"com.mega.games.poker";
    
    GameLauncher* gameLauncher = [GameLauncher instantiate];
    [gameLauncher installSignals:^{
            NSLog(@"got signal callback");
    }];
    
    MegaServicesBuilder* servicesBuilder = [MegaServicesBuilder instantiate];
    
    //analytics
    [servicesBuilder withAnalyticsRecorder:^(NSString* event, NSDictionary<NSString *,NSString *>* data) {
        NSLog(@"got event =%@  data=%@", event, data);
    }];
    
    //config
    ConfigProviderBuilder* configBuilder = [ConfigProviderBuilder instantiate];
    [configBuilder withFeatureFlagProvider:^BOOL(NSString * feature) {
        return false;
    }];
    NSDictionary<NSString*, NSString*>* gameConfig = @{};
    [configBuilder withGameConfig:gameConfig];
    [configBuilder withTourConfigProvider:^NSString *(NSString * key) {
        return @"";
    }];
    [configBuilder withRemoteConfigProvider:^id(NSString * key, NSString * type) {
        NSLog(@"asked for remoteConfig. key=%@ type=%@", key, type);
        return nil;
    }];
    
    [servicesBuilder withConfigProviderBuilder:configBuilder];
    //end-config
    
    //exceptionhandler
    [servicesBuilder withExceptionRecorder:^(NSError * err) {
        NSLog(@"got exception domain=%@", err.domain);
    }];
    
    //permission checker
    [servicesBuilder withPermissionChecker:^BOOL(NSString * perm) {
        return false;
    }];
    
    //show profile
    [servicesBuilder withShowProfileHandler:^BOOL{
        return false;
    }];
    
    //versions
    [servicesBuilder withRuntimeInfo:@"SIT_N_GO" gameSupportLibVersion:@"0.1.2" appVersion:@"1.0.0"];
    
    //multiplayclient
    MultiPlayClientProvider* mpClientProvider = [MultiPlayClientProvider instantiate];
    [mpClientProvider withClientForMatchProvider:^MultiPlayClient *(NSString * matchId) {
        return nil;
    }];
    [mpClientProvider withClientProvider:^MultiPlayClient *{
        return nil;
    }];
    
    [servicesBuilder withMultiPlayClientProvider:mpClientProvider];
    //end-multiplayclient
    
    //uiManager
    GameUIManagerBuilder* uiManagerBuilder = [GameUIManagerBuilder instantiate];
    [uiManagerBuilder setGameOverListener:^(long score) {
        NSLog(@"game over. score=%ld", score);
    }];
    [uiManagerBuilder setPlayAgainListener:^{
        NSLog(@"onPlayagain called");
    }];
    [uiManagerBuilder setQuitListener:^{
        NSLog(@"onQuit called");
    }];
    //end-uiManager
    
    UIViewController* gameView = [gameLauncher gameViewController:clazz frameworkId:fw
                                              megaServicesBuilder:servicesBuilder uiManagerBuilder:uiManagerBuilder];
    
    self.window.rootViewController = gameView;
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
