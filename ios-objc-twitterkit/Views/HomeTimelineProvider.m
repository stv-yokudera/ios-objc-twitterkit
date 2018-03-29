//
//  HomeTimelineProvider.m
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/27.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import "HomeTimelineProvider.h"
#import "TweetCell.h"
#import "TwitterProfileImageDao.h"

@interface HomeTimelineProvider ()
@property (nonatomic) NSMutableArray <NSURLSessionTask *> *tasks;
@end

typedef void (^DownloadCompletion)(NSData *data);

@implementation HomeTimelineProvider

#pragma mark - Initializer

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tasks = [@[] mutableCopy];
    }
    return self;
}

#pragma mark - Private methods

- (void)downloadProfileImageForItemAtIndex:(NSInteger)index completion:(DownloadCompletion)completion {
    NSURL *url = [NSURL URLWithString:self.tweets[index].profileImageUrl];

    NSURLSessionTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:
                              ^(NSData *data, NSURLResponse *response, NSError *error) {
                                  if (error) {
                                      DLOG(@"%@", error.localizedFailureReason);
                                      return;
                                  }

                                  if (!data) {
                                      DLOG(@"Image data is nil.");
                                      return;
                                  }

                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      // 画像データを保存
                                      TwitterProfileImage *profileImage = [[TwitterProfileImage alloc] initWithProfileID:self.tweets[index].tweetID
                                                                                                               imageData:data];
                                      [TwitterProfileImageDao insertOrReplace:profileImage];

                                      if (completion) {
                                          completion(data);
                                      }
                                  });
                              }];
    [task resume];
    [self.tasks addObject:task];
}

- (void)cancelDownloadingImageForItemAtIndex:(NSInteger)index {
    NSURL *url = [NSURL URLWithString:self.tweets[index].profileImageUrl];

    for (NSURLSessionTask *task in [self.tasks reverseObjectEnumerator]) {
        if ([task.originalRequest.URL isEqual:url]) {
            [task cancel];
            [self.tasks removeObject:task];
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:[TweetCell identifier]
                                                      forIndexPath:indexPath];
    cell.tweet = self.tweets[indexPath.row];

    NSData *imageData = [TwitterProfileImageDao selectByID:self.tweets[indexPath.row].tweetID].imageData;

    // ダウンロード済みでない場合ダウンロードする
    if (!imageData) {
        [self downloadProfileImageForItemAtIndex:indexPath.row completion:^(NSData *imageData) {
            TwitterProfileImage *selectedImage = [TwitterProfileImageDao selectByID:self.tweets[indexPath.row].tweetID];
            cell.profileImage = [UIImage imageWithData:selectedImage.imageData];
        }];
    } else {
        cell.profileImage = [UIImage imageWithData:imageData];
    }
    return cell;
}

#pragma mark - UITableViewDataSourcePrefetching

- (void)tableView:(UITableView *)tableView prefetchRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    for (NSIndexPath *indexPath in indexPaths) {
        [self downloadProfileImageForItemAtIndex:indexPath.row completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView cancelPrefetchingForRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    for (NSIndexPath *indexPath in indexPaths) {
        [self cancelDownloadingImageForItemAtIndex:indexPath.row];
    }
}
@end
