//
//  HomeTimelineAPI.h
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/25.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import Foundation;
#import "HomeTimelineTweet.h"

@protocol HomeTimelineAPIStatus <NSObject>
- (void)loading;
- (void)loaded:(NSArray <HomeTimelineTweet *> * _Nonnull)result;
- (void)error:(NSError *_Nonnull)error;

@end

@interface HomeTimelineAPI : NSObject
@property (weak, nullable, nonatomic) id <HomeTimelineAPIStatus> delegate;
- (void)loadWithUserId:(NSString * _Nonnull)userID;
@end
