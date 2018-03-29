//
//  SQLiteHelper.h
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/28.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import FMDB;
@import Foundation;
#import "WriteTransactionElements.h"

@interface SQLiteHelper : NSObject
@property (nonatomic) FMDatabase *fmdb;
+ (SQLiteHelper *)sharedInstance;
- (BOOL)writeTransaction:(NSArray <WriteTransactionElements *> *)sqls;
@end
