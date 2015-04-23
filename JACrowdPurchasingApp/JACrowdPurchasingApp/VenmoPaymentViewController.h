//
//  VenmoPaymentViewController.h
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 4/23/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface VenmoPaymentViewController : UIViewController

@property (strong, nonatomic) NSString *price;

@property (nonatomic) NSInteger numberOfPeople;

@property (strong, nonatomic) NSString *campaignTitle;

@property (nonatomic) NSArray *listOfFriends;

@end
