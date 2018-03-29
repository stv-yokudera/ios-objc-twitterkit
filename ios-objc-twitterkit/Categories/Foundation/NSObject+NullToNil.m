//
//  NSObject+NullToNil.m
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/26.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import "NSObject+NullToNil.h"

@implementation NSObject (NullToNil)

- (__kindof NSObject *)nullToNil {
    return [self isEqual:[NSNull null]] ? nil : self;
}

@end
