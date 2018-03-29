//
//  HomeTimelineViewController.m
//  ios-objc-twitterkit
//
//  Created by OkuderaYuki on 2018/03/25.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@import SVProgressHUD;
#import "HomeTimelineAPI.h"
#import "HomeTimelineProvider.h"
#import "HomeTimelineViewController.h"
#import "Reachability.h"
#import "TwitterSessionStore.h"

@interface HomeTimelineViewController () <HomeTimelineAPIStatus>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) HomeTimelineAPI *homeTimelineAPI;
@property (nonatomic) HomeTimelineProvider *provider;
@end

@implementation HomeTimelineViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

#pragma mark - Private Methods

- (void)setup {

    self.homeTimelineAPI = [[HomeTimelineAPI alloc] init];
    self.homeTimelineAPI.delegate = self;

    [self twitterLogin];
    [self setupTableView];
}

- (void)setupTableView {

    self.provider = [[HomeTimelineProvider alloc] init];
    self.tableView.prefetchDataSource = self.provider;
    self.tableView.dataSource = self.provider;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.tableView.refreshControl = self.refreshControl;
    [self.refreshControl addTarget:self
                            action:@selector(pullToRefresh)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)twitterLogin {

    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    if ([reachability currentReachabilityStatus] == NotReachable) {
        [self showSimpleAlertWithMessage:NSLocalizedString(@"OFFLINE", @"")];
    }

    // セッションがあるか
    id<TWTRAuthSession> session = [TwitterSessionStore loggedInUserAuthSession];

    if (session) {
        // セッションがある場合、ホームタイムライン取得要求をする
        [self.homeTimelineAPI loadWithUserId:session.userID];
    } else {
        // セッションがない場合、ログイン要求をする

        __weak typeof(self) weakSelf = self;
        [TwitterSessionStore login:^(NSString *loggedInUserID, NSString *errorMessage) {

            __strong typeof(self) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }

            if (errorMessage) {
                [strongSelf showSimpleAlertWithMessage:errorMessage];
                return;
            }

            // loggedInUserIdを使用してホームタイムライン取得要求をする
            [weakSelf.homeTimelineAPI loadWithUserId:loggedInUserID];
        }];
    }
}

- (void)endRefreshing {

    if (self.refreshControl.isRefreshing) {
        [self.refreshControl endRefreshing];
    }
}

- (void)pullToRefresh {

    [self.refreshControl beginRefreshing];
    [self twitterLogin];
}

#pragma mark - HomeTimelineAPIStatus

- (void)loading {

    if (!self.refreshControl.isRefreshing) {
        [SVProgressHUD show];
    }
}

- (void)loaded:(NSArray <HomeTimelineTweet *> *)result {

    [SVProgressHUD dismiss];
    [self endRefreshing];

    self.provider.tweets = result;
    [self.tableView reloadData];
}

- (void)error:(NSError *)error {
    
    [SVProgressHUD dismiss];
    [self endRefreshing];
    [self showSimpleAlertWithMessage:error.localizedDescription];
}

@end
