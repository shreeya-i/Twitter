//
//  APIManager.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "BDBOAuth1SessionManager.h"
#import "BDBOAuth1SessionManager+SFAuthenticationSession.h"
#import "Tweet.h"

@interface APIManager : BDBOAuth1SessionManager

+ (instancetype)shared;

- (void)getHomeTimelineWithCompletion:(void(^)(NSArray *tweets, NSError *error))completion;

- (void)postStatusWithText:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion;

- (void)favorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;

- (void)unfavorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;

- (void)retweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;

- (void)unretweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;

- (void)getUserTimeline:(User *)user completion:(void (^)(NSArray *tweets, NSError *error))completion;

- (void)getHomeTimeline:(NSNumber *) count completion:(void(^)(NSArray *tweets, NSError *error))completion;

- (void)getUserSettings:(void (^)(NSString *screenName, NSError *error))completion;

- (void)showUser:(NSString *)screenName completion:(void (^)(User *, NSError *))completion;

- (void)postStatusWithTextReply:(NSString *)text status_id: (NSString *) status_id completion:(void (^)(Tweet *, NSError *))completion;

// Add other functions here

@end
