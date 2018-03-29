//
//  WriteTransactionElements.m
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/28.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import "WriteTransactionElements.h"

@implementation WriteTransactionElements

- (instancetype)initWithSQL:(NSString *)sqlStatement arguments:(NSArray *)arguments {
    self = [super init];
    if (self) {
        self.sqlStatement = sqlStatement;
        self.arguments = arguments;
    }
    return self;
}
@end
