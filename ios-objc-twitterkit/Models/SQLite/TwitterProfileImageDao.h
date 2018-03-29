//
//  TwitterProfileImageDao.h
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/28.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import Foundation;
#import "TwitterProfileImage.h"

@interface TwitterProfileImageDao : NSObject

+ (TwitterProfileImage *)selectByID:(NSString *)profileID;
+ (void)insertOrReplace:(TwitterProfileImage *)newData;
@end
