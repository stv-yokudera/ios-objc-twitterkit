//
//  TwitterProfileImageDao.m
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/28.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import "SQLiteHelper.h"
#import "TwitterProfileImageDao.h"
#import "WriteTransactionElements.h"

@implementation TwitterProfileImageDao

+ (TwitterProfileImage *)selectByID:(NSString *)profileID {

    NSString *sqlStatement = @"SELECT * FROM TwitterProfileImage WHERE profile_id = ?";
    [[SQLiteHelper sharedInstance].fmdb open];
    FMResultSet *results = [[SQLiteHelper sharedInstance].fmdb executeQuery:sqlStatement
                                                       withArgumentsInArray:@[profileID]];

    TwitterProfileImage *twitterProfileImageObject = nil;
    while ([results next]) {
        twitterProfileImageObject = [[TwitterProfileImage alloc] initWithFMResultSet:results];
    }

    [[SQLiteHelper sharedInstance].fmdb close];
    return twitterProfileImageObject;
}

+ (void)insertOrReplace:(TwitterProfileImage *)newData {

    NSString *sqlStatement = @"INSERT OR REPLACE INTO TwitterProfileImage (profile_id, image_data) VALUES(?, ?)";
    NSArray *arguments = @[newData.profileID, newData.imageData];
    WriteTransactionElements *element = [[WriteTransactionElements alloc] initWithSQL:sqlStatement
                                                                            arguments:arguments];
    [[SQLiteHelper sharedInstance] writeTransaction:@[element]];
}
@end
