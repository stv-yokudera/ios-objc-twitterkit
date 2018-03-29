//
//  TweetCell.h
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/25.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import UIKit;
#import "HomeTimelineTweet.h"

@interface TweetCell : UITableViewCell
@property (nonatomic) HomeTimelineTweet *tweet;
@property (nonatomic) UIImage *profileImage;
+ (NSString *)identifier;
@end
