//
//  DVYOtherCampaignViewController.m
//  JACrowdPurchasingApp
//
//  Created by Justin on 3/30/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYOtherCampaignViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <PFUser.h>
#import "DVYUser.h"
#import "DVYCampaignDetailView.h"

@interface DVYOtherCampaignViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *decisionSwitch;

@end

@implementation DVYOtherCampaignViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        _campaign = [[DVYCampaign alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.currentUser setDVYUSerToCurrentUser];
    
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"DVYCampaignDetailView" owner:self options:nil];
    
    DVYCampaignDetailView *detailView = [nibViews firstObject];
    detailView.campaignTitle.text = self.campaign.title;
    detailView.campaignDetails.text = self.campaign.detail;
    DVYUser *host = self.campaign.host;
    [host fetchIfNeeded];
    detailView.hostName.text = host[@"fullName"];
    detailView.deadline.text = [NSString stringWithFormat:@"%@", self.campaign.deadline];
    
    //self.decisionSwitch = [[UISwitch alloc] init];
    
    [self.view addSubview:detailView];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchSwitched:(id)sender {
    
}

- (IBAction)exitTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
