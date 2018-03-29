//
//  AppDelegate.m
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/24.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import Keys;
@import TwitterKit;
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    IosObjcTwitterkitKeys *keys = [[IosObjcTwitterkitKeys alloc] init];
    [[TWTRTwitter sharedInstance] startWithConsumerKey:keys.twitterKitConsumerKey
                                        consumerSecret:keys.twitterKitConsumerSecret];

    return YES;
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

    if ([[TWTRTwitter sharedInstance] application:app openURL:url options:options]) {
        return YES;
    }
    // failed to open.
    return NO;
}


@end
