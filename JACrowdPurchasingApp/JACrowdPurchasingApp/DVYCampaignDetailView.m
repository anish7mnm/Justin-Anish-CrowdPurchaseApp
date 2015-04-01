//
//  DVYCampaignDetailView.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/25/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYCampaignDetailView.h"
#import "DVYCampaign.h"
#import "DVYInviteFriendsTableViewController.h"


@implementation DVYCampaignDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)updateView
{
    self.campaignTitle.text = self.campaign.title;
    self.campaignDetails.text = self.campaign.detail;
    
}


- (IBAction)seePeopleCommitted:(id)sender {
    
//    UIStoryboard *myStoryboard = [UIStoryboard storyboardWithName:@"CreateFlow" bundle:nil];
//    
//    UIViewController *friendsCommitted = [myStoryboard instantiateInitialViewController];
//    [self.inputViewController presentViewController:friendsCommitted animated:YES completion:nil];
    
}


@end
