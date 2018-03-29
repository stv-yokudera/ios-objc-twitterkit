//
//  WriteTransactionElements.h
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/28.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import Foundation;

@interface WriteTransactionElements : NSObject

@property (nonatomic) NSString *sqlStatement;
@property (nonatomic) NSArray *arguments;
- (instancetype)initWithSQL:(NSString *)sqlStatement arguments:(NSArray *)arguments;
@end
