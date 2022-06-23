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

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.profileTableView.dataSource = self;
    self.profileTableView.delegate = self;
    //self.profileTableView.rowHeight = UITableViewAutomaticDimension;
    self.profileTableView.rowHeight = 250;
    [self fetchTweetss];
    
    self.nameLabel.text = self.user.name;
    self.usernameLabel.text = [NSString stringWithFormat:@"@%@", self.user.screenName];
    self.followersLabel.text = [NSString stringWithFormat:@"%@ Followers", self.user.followers];
    self.followingLabel.text = [NSString stringWithFormat:@"%@ Following", self.user.friends];

    NSString *URLString = self.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    [self.profilePicture setImageWithURL: url];
    
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width/2;
    self.profilePicture.clipsToBounds = YES;
    self.profilePicture.layer.borderWidth = 3.0f;
    self.profilePicture.layer.borderColor = [UIColor whiteColor].CGColor;

    NSString *URLString2 = self.user.header;
    NSURL *url2 = [NSURL URLWithString:URLString2];
    [self.headerImage setImageWithURL: url2];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProfileTweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileTweetCell" forIndexPath:indexPath];
    
    cell.tweet = self.arrayOfTweets[indexPath.row];
    //cell.delegate = self;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfTweets.count;
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
