//
//  NSError+TwitterError.m
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/26.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import "NSError+TwitterError.h"

static NSString *const TwitterErrorDomain = @"jp.st-ventures.ios-objc-twitterkit.TwitterError";

@implementation NSError (TwitterError)

+ (NSError *)errorWithTwitterErrorCode:(TwitterErrorCode)code {

    NSString *localizedDescription = @"";

    switch (code) {
        case TwitterErrorCodeNone:
            localizedDescription = @"";
            break;

        case TwitterErrorCodeOffline:
            localizedDescription = NSLocalizedString(@"OFFLINE", @"");
            break;
        case TwitterErrorCodeTimeout:
            localizedDescription = NSLocalizedString(@"TIMEOUT", @"");
            break;
        case TwitterErrorCodeGetTimelineFailure:
            localizedDescription = NSLocalizedString(@"FAILED_TO_GET_TIMELINE", @"");
            break;
    }

    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:localizedDescription
                                                         forKey:NSLocalizedDescriptionKey];

    NSError *error = [[self class] errorWithDomain:TwitterErrorDomain
                                              code:code
                                          userInfo:userInfo];
    return error;
}
@end
