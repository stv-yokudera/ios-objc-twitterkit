//
//  HomeTimelineParamsBuilder.m
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/25.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import "HomeTimelineParamsBuilder.h"

@implementation HomeTimelineParamsBuilder

+ (NSDictionary <NSString *, NSString *> *)buildWithRecordCount:(NSInteger)recordCount {
    return @{ @"count": [NSString stringWithFormat:@"%ld", (long)recordCount] };
}
@end
