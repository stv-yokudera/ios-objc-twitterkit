//
//  NSObject+NullToNil.h
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/26.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import Foundation;

@interface NSObject (NullToNil)

- (__kindof NSObject *)nullToNil;
@end
