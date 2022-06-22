//
//  ProfileViewController.m
//  twitter
//
//  Created by Shreeya Indap on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIKit+AFNetworking.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameLabel.text = self.user.name;
    self.usernameLabel.text = self.user.screenName;
    self.followersLabel.text = self.user.followers;
    self.followingLabel.text = self.user.friends;

    NSString *URLString = self.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    [self.profilePicture setImageWithURL: url];

    NSString *URLString2 = self.user.header;
    NSURL *url2 = [NSURL URLWithString:URLString2];
    [self.headerImage setImageWithURL: url2];
    
    
    // Do any additional setup after loading the view.
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
