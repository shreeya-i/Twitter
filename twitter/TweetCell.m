//
//  TweetCell.m
//  twitter
//
//  Created by Shreeya Indap on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

- (void)setTweet:(Tweet *)tweet {
    
    _tweet = tweet;
    [self refreshData];
    
    }

-(void)refreshData {
    self.nameLabel.text = self.tweet.user.name;
    self.usernameLabel.text = self.tweet.user.screenName;
    self.dateLabel.text = self.tweet.createdAtString;
    self.tweetText.text = self.tweet.text;
    NSString *URLString = self.tweet.user.profilePicture;
    [self.favoriteButton setTitle: [NSString stringWithFormat:@"%i", self.tweet.favoriteCount]  forState:UIControlStateNormal];
    [self.retweetButton setTitle: [NSString stringWithFormat:@"%i", self.tweet.retweetCount]  forState:UIControlStateNormal];
    NSURL *url = [NSURL URLWithString:URLString];
    //NSData *urlData = [NSData dataWithContentsOfURL:url];
    [self.profilePic setImageWithURL: url];
//    if (self.tweet.favorited == YES) {
//        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"]];
//    }
}

- (IBAction)didTapFavorite:(id)sender {
    self.tweet.favorited = !self.tweet.favorited;
    
    if (self.tweet.favorited == YES){
        self.tweet.favoriteCount += 1;
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                 [self refreshData];
             }
         }];
    }
    else{
        self.tweet.favoriteCount -= 1;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
                 [self refreshData];
             }
         }];
    }
    
}

- (IBAction)didTapRetweet:(id)sender {
    self.tweet.retweeted = !self.tweet.retweeted;
    
    if (self.tweet.retweeted == YES){
        self.tweet.retweetCount += 1;
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                 [self refreshData];
             }
         }];
        
        [self refreshData];
        
    }
    else{
        self.tweet.retweetCount -= 1;
        
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                 [self refreshData];
             }
         }];
        
        [self refreshData];
    }
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
