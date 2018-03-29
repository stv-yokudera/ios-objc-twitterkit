//
//  NSString+DirectoryPath.m
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/28.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import "NSString+DirectoryPath.h"

@implementation NSString (DirectoryPath)

+ (NSString *)documentsDirectoryPath {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}
@end
