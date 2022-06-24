//
//  ProfileViewController.h
//  twitter
//
//  Created by Shreeya Indap on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController

@property (nonatomic, strong) User *user;
@property (weak, nonatomic) IBOutlet UITableView *profileTableView;

@property (nonatomic, strong) NSMutableArray *arrayOfTweets;

@end

NS_ASSUME_NONNULL_END
