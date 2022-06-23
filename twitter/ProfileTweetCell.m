//
//  ProfileTweetCell.m
//  twitter
//
//  Created by Shreeya Indap on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ProfileTweetCell.h"

@implementation ProfileTweetCell

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    self.tweetText.text = tweet.text;
    self.nameLabel.text = tweet.user.name;
    self.usernameLabel.text = tweet.user.screenName;
    self.dateLabel.text = tweet.createdAtString;
    
    self.profilePicture.layer.cornerRadius  = self.profilePicture.frame.size.width/2;
    self.profilePicture.clipsToBounds = YES;
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:urlData];
    self.profilePicture.image = image;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
