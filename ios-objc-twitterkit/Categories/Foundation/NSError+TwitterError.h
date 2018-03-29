//
//  NSError+TwitterError.h
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/26.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import Foundation;

typedef enum : NSInteger {
    TwitterErrorCodeNone = 0,
    TwitterErrorCodeOffline,
    TwitterErrorCodeTimeout,
    TwitterErrorCodeGetTimelineFailure
} TwitterErrorCode;

@interface NSError (TwitterError)

+ (NSError *)errorWithTwitterErrorCode:(TwitterErrorCode)code;
@end
