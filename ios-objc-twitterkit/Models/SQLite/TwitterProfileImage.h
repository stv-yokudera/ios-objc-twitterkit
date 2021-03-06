//
//  TwitterProfileImage.h
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/28.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import FMDB;
@import Foundation;

@interface TwitterProfileImage : NSObject
@property (nonatomic) NSString *profileID;
@property (nonatomic) NSData *imageData;

- (instancetype)initWithProfileID:(NSString *)profileID imageData:(NSData *)imageData;
- (instancetype)initWithFMResultSet:(FMResultSet *)results;
@end
