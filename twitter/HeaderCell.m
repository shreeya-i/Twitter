//
//  HeaderCell.m
//  twitter
//
//  Created by Shreeya Indap on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "HeaderCell.h"
#import "UIKit+AFNetworking.h"


@implementation HeaderCell

- (void)setUser:(User *)user {
    _user = user;
    self.nameLabel.text = self.user.name;
    self.usernameLabel.text = [NSString stringWithFormat:@"@%@", self.user.screenName];
    self.followersLabel.text = [NSString stringWithFormat:@"%@ Followers", self.user.followers];
    self.followingLabel.text = [NSString stringWithFormat:@"%@ Following", self.user.friends];
    self.bioLabel.text = self.user.bio;
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
