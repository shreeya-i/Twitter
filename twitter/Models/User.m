//
//  User.m
//  twitter
//
//  Created by Shreeya Indap on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicture = dictionary[@"profile_image_url_https"];
        NSString* followersString = [NSString stringWithFormat:@"%@", dictionary[@"followers_count"]];
        self.followers = followersString;
        NSString* friendsString = [NSString stringWithFormat:@"%@", dictionary[@"friends_count"]];
        self.friends = friendsString;
        self.header = dictionary[@"profile_banner_url"];
        self.bio = dictionary[@"description"];
        
    
    // Initialize any other properties
        
    }
    return self;
}

@end
