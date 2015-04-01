//
//  DVYParseAPIClient.h
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/23/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@class DVYUser;
@interface DVYParseAPIClient : NSObject

+ (void) logInWithFacebookWithCompletionBlock: (void (^)(void))completionBlock AndSignUpComletionBlock: (void (^)(void))signUpCompletionBlock;

+ (void) getSelfCampaignsWithCompletionBlock: (void (^)(NSArray *selfCampaigns)) completionBlock;

+ (void) getOthersCampaignsWithCompletionBlock:(void (^)(NSArray *othersCampaign))completionBlock;

+ (void) getFacebookFriendsWithCompletionBlock: (void (^)(NSArray *arrayFriends)) completionBlock;

@end
