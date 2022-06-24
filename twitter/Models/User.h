//
//  User.h
//  twitter
//
//  Created by Shreeya Indap on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

//Added properties

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profilePicture;
@property (nonatomic, strong) NSString *followers;
@property (nonatomic, strong) NSString *friends;
@property (nonatomic, strong) NSString *header;
@property (nonatomic, strong) NSString *bio;

//Initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
