//
//  HomeTimelineParamsBuilder.h
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/25.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import Foundation;

@interface HomeTimelineParamsBuilder : NSObject

+ (NSDictionary <NSString *, NSString *> *)buildWithRecordCount:(NSInteger)recordCount;
@end
