//
//  TwitterSessionStore.m
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/25.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import "TwitterSessionStore.h"

@implementation TwitterSessionStore

+ (id<TWTRAuthSession>)loggedInUserAuthSession {
    return [TWTRTwitter sharedInstance].sessionStore.session;
}

+ (void)login:(LoginResult)result {

    [[TWTRTwitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError * error) {

        if (error) {
            DLOG(@"%@", error.localizedFailureReason);
            result(nil, NSLocalizedString(@"FAILED_TO_LOGIN", @""));
        }

        if (!session) {
            DLOG(@"session is nil.");
            result(nil, NSLocalizedString(@"FAILED_TO_LOGIN", @""));
        }

        result(session.userID, nil);
    }];
}
@end
