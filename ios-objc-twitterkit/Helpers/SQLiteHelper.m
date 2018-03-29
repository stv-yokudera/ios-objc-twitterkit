//
//  SQLiteHelper.m
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/28.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import "SQLiteHelper.h"


@implementation SQLiteHelper

static SQLiteHelper *sharedSQLiteHelper = nil;

+ (SQLiteHelper *)sharedInstance {
    @synchronized (self) {
        if (!sharedSQLiteHelper) {
            sharedSQLiteHelper = [[SQLiteHelper alloc] init];
        }
    }
    return sharedSQLiteHelper;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *dbPath = [[NSString documentsDirectoryPath] stringByAppendingPathComponent:@"app.db"];
        self.fmdb = [[FMDatabase alloc] initWithPath: dbPath];

#if DEBUG
        self.fmdb.traceExecution = YES;
#endif

        // TwitterProfileImageテーブルを生成
        NSString *sql = @"CREATE TABLE IF NOT EXISTS TwitterProfileImage (profile_id TEXT PRIMARY KEY NOT NULL, image_data BLOB NOT NULL)";
        [self simpleSQL:sql];
    }
    return self;
}

- (BOOL)writeTransaction:(NSArray <WriteTransactionElements *> *)sqls {

    BOOL result = [self.fmdb open];
    if (!result) {
        DLOG(@"failed to open db.")
        return NO;
    }

    result = [self.fmdb beginTransaction];
    if (!result) {
        DLOG(@"failed to begin transaction.")
        [self.fmdb close];
        return NO;
    }

    for (WriteTransactionElements *element in sqls) {
        result = [self.fmdb executeUpdate:element.sqlStatement withArgumentsInArray:element.arguments];
        if (!result) {
            BOOL rollbackResult = [self.fmdb rollback];
            if (!rollbackResult) {
                DLOG(@"failed to rollback.")
            }
            [self.fmdb close];
            return NO;
        }
    }
    BOOL commitResult = [self.fmdb commit];
    if (!commitResult) {
        DLOG(@"failed to commit.")

        BOOL rollbackResult = [self.fmdb rollback];
        if (!rollbackResult) {
            DLOG(@"failed to rollback.")
        }
        [self.fmdb close];
        return NO;
    }
    [self.fmdb close];
    return YES;
}

#pragma mark - Private Methods

- (BOOL)simpleSQL:(NSString *)sqlStatement {
    WriteTransactionElements *element = [[WriteTransactionElements alloc] initWithSQL:sqlStatement
                                                                            arguments:@[]];
    return [self writeTransaction:@[element]];
}

@end
