//
//  TweetCell.m
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/25.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import "TweetCell.h"
#import "TwitterProfileImageDao.h"

@interface TweetCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userScreenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@end

@implementation TweetCell

+ (NSString *)identifier {
    return NSStringFromClass([TweetCell class]);
}

- (void)setTweet:(HomeTimelineTweet *)tweet {
    self.userNameLabel.text = tweet.name;
    self.userScreenNameLabel.text = tweet.screenName;
    self.tweetLabel.text = tweet.text;
}

- (void)setProfileImage:(UIImage *)profileImage {
    self.profileImageView.image = nil;
    self.profileImageView.image = profileImage;
}

@end
