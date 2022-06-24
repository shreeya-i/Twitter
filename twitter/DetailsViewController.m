//
//  DetailsViewController.m
//  twitter
//
//  Created by Shreeya Indap on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIKit+AFNetworking.h"
#import "APIManager.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViews];

}

- (void) setUpViews {
    self.nameLabel.text = self.detailTweet.user.name;
    self.usernameLabel.text = [NSString stringWithFormat:@"@%@", self.detailTweet.user.screenName];
    self.tweetText.text = self.detailTweet.text;
    self.dateLabel.text = self.detailTweet.createdAtOriginal;
    
    self.retweetsLabel.text = [NSString stringWithFormat:@"%i Retweets", self.detailTweet.retweetCount];
    
    self.likesLabel.text = [NSString stringWithFormat:@"%i Likes", self.detailTweet.favoriteCount];
    
    self.profilePicture.layer.cornerRadius  = self.profilePicture.frame.size.width/2;
    self.profilePicture.clipsToBounds = YES;
//    self.profilePic.layer.borderWidth = 3.0f;
//    self.profilePic.layer.borderColor = [UIColor blackColor].CGColor;
    
    NSString *URLString = self.detailTweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    
    [self.profilePicture setImageWithURL: url];
    
    UIImage *favorImage = [UIImage imageNamed:@"favor-icon"];
    UIImage *favorImageSelected = [UIImage imageNamed:@"favor-icon-red"];
    
    if (self.detailTweet.favorited){
        [self.favoriteButton setImage:favorImageSelected forState:UIControlStateNormal];
    }
    else{
        [self.favoriteButton setImage:favorImage forState:UIControlStateNormal];
    }
    
    UIImage *retweetImage = [UIImage imageNamed:@"retweet-icon"];
    UIImage *retweetImageSelected = [UIImage imageNamed:@"retweet-icon-green"];
    
    if (self.detailTweet.retweeted) {
        [self.retweetButton setImage:retweetImageSelected forState:UIControlStateNormal];
    } else {
        [self.retweetButton setImage:retweetImage forState:UIControlStateNormal];
    }
}

- (IBAction)didTapRetweet:(id)sender {
    self.detailTweet.retweeted = !self.detailTweet.retweeted;
    
    if (self.detailTweet.retweeted){
        self.detailTweet.retweetCount += 1;
        
        [[APIManager shared] retweet:self.detailTweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                 [self setUpViews];
             }
        }];
    }
    else{
        self.detailTweet.retweetCount -= 1;
        
        [[APIManager shared] unretweet:self.detailTweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                 [self setUpViews];
             }
         }];
    }
}

- (IBAction)didTapLike:(id)sender {
    self.detailTweet.favorited = !self.detailTweet.favorited;
    
    if (self.detailTweet.favorited){
        self.detailTweet.favoriteCount += 1;
        [[APIManager shared] favorite:self.detailTweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                 [self setUpViews];
             }
         }];
    }
    else{
        self.detailTweet.favoriteCount -= 1;
        [[APIManager shared] unfavorite:self.detailTweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
                 [self setUpViews];
             }
         }];
    }
}


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//}

@end
