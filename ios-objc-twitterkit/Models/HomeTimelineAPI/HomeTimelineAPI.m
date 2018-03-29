//
//  HomeTimelineAPI.m
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/25.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import TwitterKit;
#import "HomeTimelineAPI.h"
#import "HomeTimelineParamsBuilder.h"
#import "Reachability.h"

@implementation HomeTimelineAPI

- (void)loadWithUserId:(NSString *)userID {

    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    if ([reachability currentReachabilityStatus] == NotReachable) {
        NSError *networkError = [NSError errorWithTwitterErrorCode:TwitterErrorCodeOffline];
        [self.delegate error:networkError];
        return;
    }

    [self.delegate loading];

    TWTRAPIClient *apiClient = [[TWTRAPIClient alloc] initWithUserID:userID];
    NSString *endpoint = @"https://api.twitter.com/1.1/statuses/home_timeline.json";
    NSDictionary <NSString *, NSString *> *parameters = [HomeTimelineParamsBuilder buildWithRecordCount:20];

    NSURLRequest *request = [apiClient URLRequestWithMethod:@"GET"
                                                  URLString:endpoint
                                                 parameters:parameters
                                                      error:nil];

    __weak typeof(self) weakSelf = self;
    [apiClient sendTwitterRequest:request
                       completion:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         __strong typeof(self) strongSelf = weakSelf;
         if (!strongSelf) {
             return;
         }

         if (connectionError) {
             if (connectionError.code == NSURLErrorTimedOut) {
                 NSError *timeout = [NSError errorWithTwitterErrorCode:TwitterErrorCodeTimeout];
                 [strongSelf.delegate error:timeout];
                 return;
             }
             DLOG(@"%@", connectionError.localizedFailureReason);
             NSError *error = [NSError errorWithTwitterErrorCode:TwitterErrorCodeGetTimelineFailure];
             [strongSelf.delegate error:error];
             return;
         }

         if (!data) {
             DLOG(@"data is nil.");
             NSError *error = [NSError errorWithTwitterErrorCode:TwitterErrorCodeGetTimelineFailure];
             [strongSelf.delegate error:error];
             return;
         }

         NSError *jsonSerializationError = nil;
         NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data
                                                              options:NSJSONReadingMutableContainers
                                                                error:&jsonSerializationError];

         if (!jsonArray) {
             DLOG(@"%@", jsonSerializationError.localizedFailureReason);
             NSError *error = [NSError errorWithTwitterErrorCode:TwitterErrorCodeGetTimelineFailure];
             [strongSelf.delegate error:error];
             return;
         }

         NSMutableArray <HomeTimelineTweet *> *result = [@[] mutableCopy];
         HomeTimelineTweet *tweet = [[HomeTimelineTweet alloc] init];
         for (NSDictionary <NSString *, id> *item in jsonArray) {
             tweet.tweetID = [item[@"id_str"] nullToNil];
             tweet.text = [item[@"text"] nullToNil];

             if ([item[@"user"] nullToNil]) {
                 tweet.name = [item[@"user"][@"name"] nullToNil];
                 tweet.screenName = [item[@"user"][@"screen_name"] nullToNil];
                 tweet.profileImageUrl = [item[@"user"][@"profile_image_url_https"] nullToNil];
             } else {
                 tweet.name = nil;
                 tweet.screenName = nil;
                 tweet.profileImageUrl = nil;
             }

             [result addObject:(HomeTimelineTweet *)tweet.copy];
         }
         [strongSelf.delegate loaded:result];
     }];

}
@end
