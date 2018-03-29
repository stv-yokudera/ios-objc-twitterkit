//
//  UIViewController+SingleButtonAlert.m
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/26.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

#import "UIViewController+SingleButtonAlert.h"

@implementation UIViewController (SingleButtonAlert)
- (void)showSimpleAlertWithMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"ALERT_OK", @"")
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
