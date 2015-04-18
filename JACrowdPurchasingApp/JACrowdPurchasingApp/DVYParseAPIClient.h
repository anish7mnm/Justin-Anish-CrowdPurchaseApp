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


/**
 *  Uses [PFFacebookUtils logInWithPermissions:(NSArray *)block:^(PFUser *user, NSError *error)] to log a PFUser with Facebook. If it is the very first time, it signs him up and stores the user as a PFUser.
 *
 *  @param completionBlock       Logs the user in. Returns notihng.
 *  @param signUpCompletionBlock Sign the user up. Returns nothing.
 */

+ (void) logInWithFacebookWithCompletionBlock: (void (^)(void))completionBlock AndSignUpComletionBlock: (void (^)(void))signUpCompletionBlock;



/**
 *  Creates a PFQuery to get a list of Campaigns hosted by the current DVVY User or [PFUser currentUser].
 *
 *  @param completionBlock Returns an NSArray of DVYCampaigns hosted by the current user.
 */

+ (void) getSelfCampaignsWithCompletionBlock: (void (^)(NSArray *selfCampaigns)) completionBlock;



/**
 *  Creates a PFQuery to get a list of Campaigns the current DVYUser or [PFUser currentUser] is a part of, which is hosted by other DVYUsers.
 *
 *  @param completionBlock Returns an NSArray of DVYCampaigns hosted by other users and which the current user is a part of.
 */

+ (void) getOthersCampaignsWithCompletionBlock:(void (^)(NSArray *othersCampaign))completionBlock;



/**
 *  Creates a PFQuery to get a list of Campaigns the current DVVY User or [PFUser currentUser] has been invited to join.
 *
 *  @param completionBlock Returns an NSArray of DVYCampaigns the current user has been invited to join.
 */

+ (void) getInvitationCampaignsWithCompletionBlock:(void (^)(NSArray *invitationCampaign))completionBlock;



/**
 *  Gets a list of DVYUSers friends with the current DVYUser on Facebook. It creates an instance of FBRequest which is provided by the Facebook SDK to do so.
 *
 *  @param completionBlock Returns an NSArray consisting of DVYUsers in relationship with the current DVYUser or [PFUser currentUser]
 */

+ (void) getFacebookFriendsWithCompletionBlock: (void (^)(NSArray *arrayFriends)) completionBlock;

@end
