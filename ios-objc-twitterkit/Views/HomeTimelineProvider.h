//
//  HomeTimelineProvider.h
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/27.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import UIKit;
#import "HomeTimelineTweet.h"

@interface HomeTimelineProvider : NSObject <UITableViewDataSource, UITableViewDataSourcePrefetching>
@property (nonatomic) NSArray <HomeTimelineTweet *> *tweets;
@end
