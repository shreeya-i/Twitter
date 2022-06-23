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
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
