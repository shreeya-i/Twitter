//
//  ProfileTweetCell.h
//  twitter
//
//  Created by Shreeya Indap on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileTweetCell : UITableViewCell

@property (nonatomic, strong) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;

@end

NS_ASSUME_NONNULL_END
