//
//  ProfileViewController.m
//  twitter
//
//  Created by Shreeya Indap on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//
#import "ProfileViewController.h"
#import "UIKit+AFNetworking.h"
#import "APIManager.h"
#import "ProfileTweetCell.h"
#import "HeaderCell.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.profileTableView.dataSource = self;
    self.profileTableView.delegate = self;
    //self.profileTableView.rowHeight = UITableViewAutomaticDimension;
    self.profileTableView.rowHeight = 400;
    [self fetchTweetss];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *defaultCell = [[UITableViewCell alloc] init];
    if(indexPath.section == 0) {
        HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell" forIndexPath:indexPath];
        
        cell.user = self.user;
        return cell;
        
    } else {
        ProfileTweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileTweetCell" forIndexPath:indexPath];
        
        cell.tweet = self.arrayOfTweets[indexPath.row];
        //cell.delegate = self;
        
        return cell;
    }
    return defaultCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0) {
        return 1;
    } else {
        return self.arrayOfTweets.count;
    }
    return 0;
}

- (void)fetchTweetss {
    [[APIManager shared] getUserTimeline:self.user completion:^(NSArray *tweets, NSError *error) {
            if (tweets) {
                NSLog(@"😎😎😎 Successfully loaded user tweet timeline");
                for (Tweet *tweet in tweets) {
                    NSString *text = tweet.text;
                    NSLog(@"%@", text);
                }
                self.arrayOfTweets = [NSMutableArray arrayWithArray:tweets];
                [self.profileTableView reloadData];
            } else {
                NSLog(@"😫😫😫 Error getting user tweet timeline: %@", error.localizedDescription);
            }
        }];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
