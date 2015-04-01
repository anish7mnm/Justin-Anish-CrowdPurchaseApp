//
//  DVYUser.m
//  JACrowdPurchasingApp
//
//  Created by Justin on 3/22/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYUser.h"

@implementation DVYUser

@dynamic username;
@dynamic fullName;
@dynamic email;
@dynamic profilePicture;
@dynamic facebookID;
@dynamic currentUser;
@dynamic friends;

+(NSString *)parseClassName
{
    return @"User";
}

-(void) setDVYUSerToCurrentUser
{
    self.currentUser = [PFUser currentUser];
    self.username = self.currentUser.username;
    self.fullName = self.currentUser[@"fullName"];
    self.email = self.currentUser[@"email"];
    self.profilePicture = self.currentUser[@"profilePicture"];
}

@end
