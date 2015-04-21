//
//  DVYCampaignDetailView.h
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/25/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVYHomePageViewController.h"


@class DVYUser;
@class DVYCampaign;
@class DVYSelfCampaignViewController;


@interface DVYCampaignDetailView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;

@property (weak, nonatomic) IBOutlet UILabel *campaignTitle;

@property (weak, nonatomic) IBOutlet UITextView *campaignDetails;

@property (weak, nonatomic) IBOutlet UILabel *hostName;

@property (weak, nonatomic) IBOutlet UILabel *peopleCommited;

@property (weak, nonatomic) IBOutlet UILabel *peopleNeeded;

@property (weak, nonatomic) IBOutlet UILabel *deadline;

@property (weak, nonatomic) IBOutlet UIView *commitCountView;

@property (weak, nonatomic) IBOutlet UIView *neededCountView;

@property (weak, nonatomic) IBOutlet UIView *otherCountView;


@property (weak, nonatomic) IBOutlet UIButton *committedFriendsListButton;

@property (strong, nonatomic) DVYCampaign *campaign;

@property (strong, nonatomic) UIViewController *selfCampaignVC;

-(void)buttonAction;

- (void) updateView;

@end
