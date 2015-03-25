//
//  DVYParseAPIClient.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/23/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

#import "DVYParseAPIClient.h"
#import "DVYUser.h"

@implementation DVYParseAPIClient

+(void)logInWithFacebookWithCompletionBlock:(void (^)(void))completionBlock AndSignUpComletionBlock:(void (^)(void))signUpCompletionBlock
{

    NSArray *permissionsArray = @[ @"email", @"user_friends"];

    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        if (!user)
        {
            NSString *errorMessage = nil;
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                errorMessage = @"Uh oh. The user cancelled the Facebook login.";
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                errorMessage = [error localizedDescription];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error"
                                                            message:errorMessage
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Dismiss", nil];
            [alert show];
        }
        else if (user.isNew)
        {
            NSLog(@"User with facebook signed up and logged in!");
            NSLog(@"USER: %@", user);
            signUpCompletionBlock();
            
        }
        else
        {
            NSLog(@"User with facebook logged in!");
            completionBlock();
        }
        
    }];

}


+(void)getCampaignFromParseWithID:(NSString *)campaignID CompletionBlock:(void (^)(PFObject *))completionBlock
{
    PFQuery *query = [PFQuery queryWithClassName:@"Campaign"];
    [query getObjectInBackgroundWithId:campaignID block:^(PFObject *campaignQueried, NSError *error) {
        
        NSLog(@"%@", campaignQueried);
        completionBlock(campaignQueried);
        
    }];
}

+(void)saveCampaignFromParseWithTitle:(NSString *)title Details:(NSString *)detail Host:(DVYUser *)host MinimumCommitsNeeded:(NSInteger)minimumNeededCommits Price:(NSNumber *)price Deadline:(NSDate *)deadline CompletionBlock:(void (^)(void))completionBlock
{
    
    PFObject *campaign = [PFObject objectWithClassName:@"Campaign"];
    
    campaign[@"title"] = title;
    campaign[@"detail"] = detail;
    campaign[@"host"] = host;
    campaign[@"price"] = price;
    campaign[@"minimumNeededCommits"] = @(minimumNeededCommits);
    campaign[@"deadline"] = deadline;
    
    [campaign saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            completionBlock();
            
        } else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no! Error occurred while Saving"
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Dismiss", nil];
            [alert show];
        }
    }];
}

+(void)getUserFromParseWithEmail:(NSString *)email CompletionBlock:(void (^)(DVYUser *))completionBlock
{
    PFQuery *query = [PFUser query];
    [query whereKey:@"email" equalTo:email];
    PFUser *gotUser = [[PFUser alloc] init];
    NSArray *users = [query findObjects];
    gotUser = users[0];
//    
//    DVYUser *user = [[DVYUser alloc]init];
//    user.email = gotUser[@"email"];
//    user.name = gotUser[@"fullName"];
//    
//    completionBlock(user);

}

@end
