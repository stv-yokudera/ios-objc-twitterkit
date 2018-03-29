//
//  HomeTimelineTweet.m
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/25.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import "HomeTimelineTweet.h"

@implementation HomeTimelineTweet
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tweetID = @"";
        self.name = @"";
        self.screenName = @"";
        self.profileImageUrl = @"";
        self.text = @"";
    }
    return self;
}
- (instancetype)copyWithZone:(NSZone *)zone {

    HomeTimelineTweet *copyObject = [[[self class] allocWithZone:zone] init];

    if (copyObject) {
        copyObject.tweetID = self.tweetID;
        copyObject.name = self.name;
        copyObject.screenName = self.screenName;
        copyObject.profileImageUrl = self.profileImageUrl;
        copyObject.text = self.text;
    }
    return copyObject;
}
@end
