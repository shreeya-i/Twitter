//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "DetailsViewController.h"
#import "ProfileViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@end

@implementation TimelineViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tweetTableView reloadData];
    [self fetchTweets];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tweetTableView.dataSource = self;
    self.tweetTableView.delegate = self;
    self.tweetTableView.rowHeight = UITableViewAutomaticDimension;
    //self.tweetTableView.rowHeight = 250;
    
    [self fetchTweets];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tweetTableView insertSubview:self.refreshControl atIndex:0];

}

- (void)tweetCell:(TweetCell *)tweetCell didTap:(User *)user{
    [self performSegueWithIdentifier:@"profileSegue" sender:user];
}

- (IBAction)didTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    
    cell.tweet = self.arrayOfTweets[indexPath.row];
    cell.delegate = self;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfTweets.count;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSInteger index = [indexPath row];
//
//}

- (void)fetchTweets {
    // Get timeline
       [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
           if (tweets) {
               NSLog(@"😎😎😎 Successfully loaded home timeline");
   //            for (Tweet *tweet in tweets) {
   //                NSString *text = tweet.text;
   //                NSLog(@"%@", text);
   //            }
               self.arrayOfTweets = [NSMutableArray arrayWithArray:tweets];
               [self.tweetTableView reloadData];
           } else {
               NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
           }
           [self.refreshControl endRefreshing];
       }];
}

- (void) loadMoreData:(NSInteger)count{
    NSNumber *newcount = @(count);
    [[APIManager shared] getHomeTimeline:newcount completion:^(NSArray *tweets,
     NSError *error) {
        if (tweets) {
            NSLog(@"😎 😎 😎 Successfully loaded home timeline");
            self.arrayOfTweets =(NSMutableArray *) tweets;
            [self.tweetTableView reloadData];
            [self.refreshControl endRefreshing];
        } else {
            NSLog(@"😫 😫 😫 Error getting home timeline: %@",
             error.localizedDescription);
        }
}]; }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"composeSegue"]){
        UINavigationController *navigationController = [segue destinationViewController];
            ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
            composeController.delegate = self;
    }
    else if([segue.identifier isEqualToString:@"detailSegue"]){
//        UINavigationController *navigationController = [segue destinationViewController];
//        
        NSIndexPath *myIndexPath = [self.tweetTableView indexPathForCell:sender];
        Tweet *dataToPass = self.arrayOfTweets[myIndexPath.row];
        DetailsViewController *detailVC = [segue destinationViewController];
        detailVC.detailTweet = dataToPass;
    }
    else if ([segue.identifier isEqualToString:@"profileSegue"]){
        User *selectedUser = sender;
        ProfileViewController *profileView = [segue destinationViewController];
        profileView.user = selectedUser;
    }
    
    
}

- (void)didTweet:(nonnull Tweet *)tweet {
    [self.arrayOfTweets addObject: tweet];
    [self.tweetTableView reloadData];
    [self fetchTweets];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell
 *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row + 1 == [self.arrayOfTweets count]){
        [self loadMoreData:[self.arrayOfTweets count] + 20];
        //NSLog(@"%lu", [self.arrayOfTweets count] + 20);
} }



@end
