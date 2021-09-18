//
//  AppDelegate.m
//  TestDemo
//
//  Created by 蔡月 on 2021/2/26.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>


@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

+ (void)load {
    NSLog(@"load in appDelegate");
}

+ (void)initialize {
    NSLog(@"initialize in appDelegate");
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.name = @"aaa";
    
    NSLog(@"%@", NSHomeDirectory());
    
    NSLog(@"enter didFinishLaunchingWithOptions:%@", launchOptions);
    
    if (@available(iOS 10.0, *)) {
        NSSet<UNNotificationCategory *> *categories = ({
            NSMutableSet<UNNotificationCategory *> *set = [NSMutableSet set];
            // Add categories here if needed
            set.copy;
        });
        [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:categories];
        // set UNUserNotificationCenterDelegate
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    } else {
        // Fallback on earlier versions
    }
    
    
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            });
        }}];
    
    
    return YES;
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *str = [NSString stringWithFormat:@"Device Token=%@", deviceToken];
//    DDLogInfo(@"didRegisterForRemoteNotificationsWithDeviceToken:%@", str);
}
     

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"enter didReceiveRemoteNotification");
}


#pragma mark - UISceneSession lifecycle
- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"terminated");
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)){
    UNNotificationPresentationOptions options = UNNotificationPresentationOptionNone;
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]] && options == UNNotificationPresentationOptionNone) {
        // 前台的push不展示，但是需要统计到达
//        [[KSAppEnvironment environment] logRemoteNotification:notification.request.content.userInfo];
    }
    
    NSLog(@"enter willPresentNotification");

    if (completionHandler) {
        completionHandler(UNNotificationPresentationOptionAlert);
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)())completionHandler  API_AVAILABLE(ios(10.0)){
    
    NSLog(@"enter didReceiveNotificationResponse");
}


@end
