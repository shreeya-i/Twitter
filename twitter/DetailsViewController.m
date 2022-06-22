//
//  DetailsViewController.m
//  twitter
//
//  Created by Shreeya Indap on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIKit+AFNetworking.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameLabel.text = self.detailTweet.user.name;
    self.usernameLabel.text = self.detailTweet.user.screenName;
    self.tweetText.text = self.detailTweet.text;
    
    NSString *URLString = self.detailTweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    
    [self.profilePicture setImageWithURL: url];
    
    
    
    // Do any additional setup after loading the view.
}


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//}

@end
