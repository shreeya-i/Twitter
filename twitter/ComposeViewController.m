//
//  ComposeViewController.m
//  twitter
//
//  Created by Shreeya Indap on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"


@interface ComposeViewController () <UITextViewDelegate>
@end

@implementation ComposeViewController

- (IBAction)closePressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)tweetPressed:(id)sender {
    
    NSString *inputTweet = self.composeTextView.text;
    
    if(self.username == nil) {
        [[APIManager shared]postStatusWithText:inputTweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error composing Tweet: %@", error.localizedDescription);
            }
            else{
                [self.delegate didTweet:tweet];
                NSLog(@"Compose Tweet Success!");
            }
        }];
    }
    else {
        NSString *reply = [NSString stringWithFormat:@"@%@ %@", self.username, inputTweet];
        [[APIManager shared]postStatusWithTextReply:reply status_id:self.idStr completion:^(Tweet *tweet, NSError * error) {
            if(error){
                NSLog(@"Error composing Reply: %@", error.localizedDescription);
            }
            else{
                [self.delegate didTweet:tweet];
                NSLog(@"Compose Tweet Success!");
            }
        }];
    }
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.composeTextView.delegate = self;
    self.composeTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.composeTextView.layer.borderWidth = 1.0;
    //self.composeTextView.layer.cornerRadius = 8;
    self.composeTextView.text = @"What's happening?";
    self.composeTextView.textColor = [UIColor lightGrayColor];
    
    self.profilePicture.layer.cornerRadius  = self.profilePicture.frame.size.width/2;
    self.profilePicture.clipsToBounds = YES;
    
    UIBezierPath * imgRect = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 120, 100)];
    self.composeTextView.textContainer.exclusionPaths = @[imgRect];
    
    [[APIManager shared] getUserSettings:^(NSString *screenName, NSError *error) {
        if(error){
            NSLog(@"Error getting user settings: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Get user settings success!");
            [[APIManager shared]showUser:screenName completion:^(User *user, NSError *error) {
                if(error){
                    NSLog(@"No show user: %@", error.localizedDescription);
                }
                else {
                    NSLog(@"Yas show user: %@", error.localizedDescription);
                    NSString *URLString = user.profilePicture;
                    NSURL *url = [NSURL URLWithString:URLString];
                    NSData *urlData = [NSData dataWithContentsOfURL:url];
                    UIImage *image = [UIImage imageWithData:urlData];
                    self.profilePicture.image = image;
                }
            }];
        }
    }];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"What's happening?"]) {
         textView.text = @"";
         textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    int characterLimit = 280;
    NSString *newText = [self.composeTextView.text stringByReplacingCharactersInRange:range withString:text];
    self.characterCount.text = [NSString stringWithFormat:@"%lu / 280", (unsigned long)newText.length];
    return newText.length < characterLimit;
}

/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
