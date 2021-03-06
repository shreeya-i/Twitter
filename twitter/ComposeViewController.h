//
//  ComposeViewController.h
//  twitter
//
//  Created by Shreeya Indap on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate

- (void)didTweet:(Tweet *)tweet;

@end

@interface ComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *composeTextView;
@property (weak, nonatomic) IBOutlet UILabel *characterCount;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *idStr;
@property (nonatomic, strong) NSString *username;

@end

NS_ASSUME_NONNULL_END
