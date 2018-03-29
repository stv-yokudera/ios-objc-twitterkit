//
//  TwitterProfileImageDaoTests.m
//  ios-objc-twitterkitTests
//
//  Created by OkuderaYuki on 2018/03/29.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TwitterProfileImageDao.h"

@interface TwitterProfileImageDaoTests : XCTestCase

@end

@implementation TwitterProfileImageDaoTests

/*
 プロフィール画像をDBへ保存、DBから読み込むテスト
 */
- (void)testDao {

    NSURL *imageURL = [NSURL URLWithString:@"https://pbs.twimg.com/profile_images/440151399314124801/u18khuk5_normal.jpeg"];

    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
    NSString *testProfileID = @"1234567890";
    TwitterProfileImage *testImage = [[TwitterProfileImage alloc] initWithProfileID:testProfileID imageData:imageData];
    [TwitterProfileImageDao insertOrReplace:testImage];

    TwitterProfileImage *selectedImage = [TwitterProfileImageDao selectByID:testProfileID];
    XCTAssertEqualObjects(selectedImage.profileID, testProfileID);
    XCTAssertEqualObjects(selectedImage.imageData, imageData);
}

@end
