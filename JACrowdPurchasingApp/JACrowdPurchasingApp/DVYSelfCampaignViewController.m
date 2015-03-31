//
//  DVYSelfCampaignViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/25/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYSelfCampaignViewController.h"
#import "DVYCampaignDetailView.h"
#import "DVYCampaign.h"
#import "DVYCreateCampaignViewController.h"

@interface DVYSelfCampaignViewController ()

- (IBAction)editButtinTapped:(id)sender;

@end

@implementation DVYSelfCampaignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.accessibilityIdentifier= @"myCampaignVC";
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"DVYCampaignDetailView" owner:self options:nil];
    
    DVYCampaignDetailView *detailCampaignViewSelf = [nibViews firstObject];
    
    detailCampaignViewSelf.campaignTitle.text = self.campaign.title;
    detailCampaignViewSelf.campaignDetails.text = self.campaign.detail;
    detailCampaignViewSelf.deadline.text = [NSString stringWithFormat:@"%@", self.campaign.deadline];
    
    [self.view addSubview:detailCampaignViewSelf];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)editButtinTapped:(id)sender {
    
    DVYCreateCampaignViewController *edit = [[DVYCreateCampaignViewController alloc] init];
    edit.buttonName = @"Update";
    edit.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:edit animated:YES completion:nil];
    
}

- (IBAction)addFriendsButtinTapped:(id)sender {
}

- (IBAction)deleteButtonTapped:(id)sender {
}

@end
