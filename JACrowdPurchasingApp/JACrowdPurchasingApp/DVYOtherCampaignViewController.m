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
#import "DVYUser.h"
#import "DVYCampaignDetailView.h"
#import "DVYHomePageViewController.h"

@interface DVYOtherCampaignViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *decisionSwitch;
@property (nonatomic) BOOL joined;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic, readwrite) DVYUser *userToBeRemovedOrAdded;

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
    detailView.deadline.text = [NSString stringWithFormat:@"%@", self.campaign.deadline];

    
    PFQuery *commitedQuery = [self.campaign.committed query];
    [commitedQuery whereKey:@"username" equalTo:[PFUser currentUser].username];
    
    [commitedQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (![objects isEqualToArray:@[]]) {
            self.userToBeRemovedOrAdded = objects[0];
            self.decisionSwitch.on = YES;
            self.joined = YES;
        }
        else{
            self.decisionSwitch.on = NO;
            self.joined = NO;
        }
        
    }];
    
    
    DVYUser *host = self.campaign.host;
    detailView.hostName.text = host[@"fullName"];
    
    //self.decisionSwitch = [[UISwitch alloc] init];
    
    detailView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    [self.contentView addSubview:detailView];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchSwitched:(id)sender {
    
    if (self.joined == NO) {
        [self.campaign.committed addObject:[PFUser currentUser]];
        [self.campaign.invitees removeObject:[PFUser currentUser]];
        [self.campaign saveInBackground];
    }
    else{
        [self.campaign.committed removeObject:[PFUser currentUser]];
        [self.campaign saveInBackground];
    }
    
}

- (IBAction)exitTapped:(id)sender {
    DVYHomePageViewController *homeVC = (DVYHomePageViewController *)self.presentingViewController.childViewControllers[0];
    [homeVC refresh];

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
