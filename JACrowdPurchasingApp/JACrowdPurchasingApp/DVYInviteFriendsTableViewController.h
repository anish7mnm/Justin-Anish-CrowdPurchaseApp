//
//  DVYInviteFriendsTableViewController.h
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/25/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@class DVYCampaign;

@interface DVYInviteFriendsTableViewController : UIViewController


@property (nonatomic) NSMutableArray *friendsSelected;

@property (nonatomic) DVYCampaign *campaign;


@end
