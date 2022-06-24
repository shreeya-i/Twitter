//
//  Tweet.m
//  twitter
//
//  Created by Shreeya Indap on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "User.h"

@implementation Tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        // Is this a re-tweet?
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if (originalTweet != nil) {
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];

            // Change tweet to original tweet
            dictionary = originalTweet;
        }
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        //self.replyCount = [dictionary[@"reply_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];

        // TODO: initialize user
        
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];

        // TODO: Format and set createdAtString
        
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        // Convert String to Date
        NSDate *tweetDate = [formatter dateFromString:createdAtOriginalString];
        NSDate *curDate = [NSDate date];
                NSTimeInterval diff = [curDate timeIntervalSinceDate:tweetDate];
        
        NSInteger interval = diff;
        long seconds = interval % 60;
        long minutes = (interval / 60) % 60;
        long hours = (interval / 3600);
        if(hours > 1) {
                self.createdAtString = [NSString stringWithFormat:@"%ldh", hours];
            } else if(minutes > 1) {
                self.createdAtString = [NSString stringWithFormat:@"%ldm", minutes];
            } else {
                self.createdAtString = [NSString stringWithFormat:@"%lds", seconds];
            }


        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        
        self.createdAtOriginal = [formatter stringFromDate:tweetDate];
        
    }
    return self;
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries {
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}

@end
