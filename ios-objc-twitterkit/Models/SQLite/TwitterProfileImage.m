//
//  TwitterProfileImage.m
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/28.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import "TwitterProfileImage.h"

@implementation TwitterProfileImage

- (instancetype)initWithProfileID:(NSString *)profileID imageData:(NSData *)imageData {
    self = [super init];
    if (self) {
        self.profileID = profileID;
        self.imageData = imageData;
    }
    return self;
}

- (instancetype)initWithFMResultSet:(FMResultSet *)results {
    self = [[TwitterProfileImage alloc] initWithProfileID:[[results stringForColumn:@"profile_id"] nullToNil]
                                                imageData:[[results dataForColumn:@"image_data"] nullToNil]];
    return self;
}
@end
