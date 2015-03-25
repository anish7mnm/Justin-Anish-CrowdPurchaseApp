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

+ (void) getCampaignFromParseWithID: (NSString *)campaignID CompletionBlock: (void (^)(PFObject *campaign))completionBlock;
+ (void) saveCampaignFromParseWithTitle:(NSString *)title Details:(NSString *)detail Host:(DVYUser *)host MinimumCommitsNeeded: (NSInteger)minimumNeededCommits Price:(NSNumber *)price  Deadline:(NSDate *)deadline CompletionBlock: (void (^)(void))completionBlock;

+ (void) getUserFromParseWithEmail: (NSString *)email CompletionBlock: (void (^)(DVYUser *user))completionBlock;
+ (void) saveUserFromParseWithEmailAddress:(NSString *)emailAddress Name:(NSString *)name Password:(NSString *)password CompletionBlock: (void (^)(void))completionBlock;

@end
