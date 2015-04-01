//
//  DVYUser.h
//  JACrowdPurchasingApp
//
//  Created by Justin on 3/22/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface DVYUser : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *fullName;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *profilePicture;
@property (strong, nonatomic) NSString *facebookID;

@property (strong, nonatomic) PFUser *currentUser;;

@property (strong, nonatomic) PFRelation *friends;

-(void) setDVYUSerToCurrentUser;


@end
