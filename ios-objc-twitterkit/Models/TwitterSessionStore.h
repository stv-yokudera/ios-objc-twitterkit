//
//  TwitterSessionStore.h
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/25.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import Foundation;
@import TwitterKit;

typedef void (^LoginResult)(NSString * _Nullable loggedInUserID,
                            NSString * _Nullable errorMessage);

@interface TwitterSessionStore : NSObject
+ (_Nullable id<TWTRAuthSession>)loggedInUserAuthSession;
+ (void)login:(LoginResult _Nonnull)result;
@end
