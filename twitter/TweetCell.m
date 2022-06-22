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

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profilePic addGestureRecognizer:profileTapGestureRecognizer];
    [self.profilePic setUserInteractionEnabled:YES];
    
}

- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    [self.delegate tweetCell:self didTap:self.tweet.user];
}

-(void)refreshData {
    self.nameLabel.text = self.tweet.user.name;
    self.usernameLabel.text = self.tweet.user.screenName;
    self.dateLabel.text = self.tweet.createdAtString;
    self.tweetText.text = self.tweet.text;
    [self.favoriteButton setTitle: [NSString stringWithFormat:@"%i", self.tweet.favoriteCount]  forState:UIControlStateNormal];
    [self.retweetButton setTitle: [NSString stringWithFormat:@"%i", self.tweet.retweetCount]  forState:UIControlStateNormal];
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    //NSData *urlData = [NSData dataWithContentsOfURL:url];
    [self.profilePic setImageWithURL: url];
    
    
    //Date Stuff:
    
    
    
    
    self.dateLabel.text = self.tweet.createdAtString;
    
    UIImage *favorImage = [UIImage imageNamed:@"favor-icon"];
    UIImage *favorImageSelected = [UIImage imageNamed:@"favor-icon-red"];
    if (self.tweet.favorited) {
        [self.favoriteButton setImage:favorImageSelected forState:UIControlStateNormal];
    } else {
        [self.favoriteButton setImage:favorImage forState:UIControlStateNormal];
    }
    
    UIImage *retweetImage = [UIImage imageNamed:@"retweet-icon"];
    UIImage *retweetImageSelected = [UIImage imageNamed:@"retweet-icon-green"];
    if (self.tweet.retweeted) {
        [self.retweetButton setImage:retweetImageSelected forState:UIControlStateNormal];
    } else {
        [self.retweetButton setImage:retweetImage forState:UIControlStateNormal];
    }
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
