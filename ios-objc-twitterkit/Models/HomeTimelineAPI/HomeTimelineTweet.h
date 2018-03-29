//
//  HomeTimelineTweet.h
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/25.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import Foundation;

@interface HomeTimelineTweet : NSObject <NSCopying>
@property (nonatomic) NSString *tweetID;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *screenName;
@property (nonatomic) NSString *profileImageUrl;
@property (nonatomic) NSString *text;
@end
