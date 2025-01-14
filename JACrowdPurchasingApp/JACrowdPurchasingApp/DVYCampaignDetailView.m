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
#import "DVYCommittedFriendsCollectionViewController.h"


@interface DVYCampaignDetailView ()

@property (weak, nonatomic) IBOutlet UIButton *committedFriendsListButton;

@end


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
    self.campaignTitle.text = [self.campaign.title uppercaseString];
    self.campaignDetails.text = self.campaign.detail;
    self.deadline.text = [self settingDate];
    [self bringSubviewToFront:self.committedFriendsListButton];

}



-(NSString *) settingDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    
    NSString *stringDate = [dateFormatter stringFromDate:self.campaign.deadline];
    
    NSTimeInterval secondsBetween = [self.campaign.deadline timeIntervalSinceDate:[NSDate date]];
    
    NSInteger numberOfDays = secondsBetween / 86400;
    
    return [NSString stringWithFormat:@"%ld", (long)numberOfDays];
}


//For the future

- (IBAction)seePeopleCommitted:(id)sender {
    NSLog(@"campaigndetailviewtapped");
    [self.delegate presentCollectionView];
    
//    UIStoryboard *myStoryboard = [UIStoryboard storyboardWithName:@"CreateFlow" bundle:nil];
//    
//    UIViewController *friendsCommitted = [myStoryboard instantiateInitialViewController];
//    [self.inputViewController presentViewController:friendsCommitted animated:YES completion:nil];
    
}


@end
