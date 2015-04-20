//
//  DVYOtherCampaignViewController.m
//  JACrowdPurchasingApp
//
//  Created by Justin on 3/30/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYOtherCampaignViewController.h"
#import "DVYCommittedFriendsCollectionViewController.h"
#import "DVYHomePageViewController.h"

#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

#import "DVYUser.h"
#import "DVYCampaignDetailView.h"
#import "UIImage+animatedGIF.h"

@interface DVYOtherCampaignViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *decisionSwitch;

@property (nonatomic) BOOL joined;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic, readwrite) DVYUser *userToBeRemovedOrAdded;

@property (nonatomic) DVYCampaignDetailView *detailView;

@end

@implementation DVYOtherCampaignViewController


#pragma mark - Initializer

-(instancetype)init
{
    self = [super init];
    if (self) {
        _campaign = [[DVYCampaign alloc] init];
    }
    return self;
}



#pragma mark - View Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self.currentUser setDVYUSerToCurrentUser];
    
    [self settingUpDetailView];

    
    [self settingUserJoinedLogic];
    
    
    [self displayingDeadline];
    
    [self displayingNumberOfCommittedUsers];
    
    [self displayingUserProfilePicture];
    
    self.detailView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
    [self.contentView addSubview:self.detailView];
    
}


#pragma mark - View Helper Methods

- (void)displayingDeadline
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"MM/dd/yy"];
    
    NSString *stringDate = [dateFormatter stringFromDate:self.campaign.deadline];
    
    self.detailView.deadline.text = stringDate;
}


- (void)settingUpDetailView
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"DVYCampaignDetailView" owner:self options:nil];
    
    self.detailView = [nibViews firstObject];
    
    self.detailView.selfCampaignVC = self;
    
    [self.detailView buttonAction];
    
    self.detailView.campaignTitle.text = self.campaign.title;
    
    self.detailView.campaignDetails.text = self.campaign.detail;
    
    DVYUser *host = self.campaign.host;
    
    self.detailView.hostName.text = host[@"fullName"];
    
    self.detailView.peopleNeeded.text = [NSString stringWithFormat:@"%@", self.campaign.minimumNeededCommits];
}


- (void)displayingNumberOfCommittedUsers
{
    PFQuery *query = [self.campaign.committed query];
    
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error)
    {
        NSInteger count = (NSInteger)number;
        self.detailView.peopleCommited.text = [NSString stringWithFormat:@"%ld", count];
    }];
}


- (void)displayingUserProfilePicture
{
    Item *campaignItem = self.campaign.item;
    
    PFFile *image = [campaignItem objectForKey:@"itemImage"];
    
    if (image)
    {
        [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                self.detailView.profilePicture.image = [UIImage imageWithData:data];
                // Add a nice corner radius to the image
                //                self.detailCampaignViewSelf.profilePicture.layer.cornerRadius = 8.0f;
                self.detailView.profilePicture.layer.masksToBounds = YES;                }
        }];
        
    } else
    {
        NSURL *pusheenDance = [NSURL URLWithString:@"http://33.media.tumblr.com/tumblr_m9hbpdSJIX1qhy6c9o1_400.gif"];
        self.detailView.profilePicture.image = [UIImage animatedImageWithAnimatedGIFURL:pusheenDance];
        self.detailView.profilePicture.contentMode = UIViewContentModeScaleAspectFill;
        
    }
}


- (void)settingUserJoinedLogic
{
    PFQuery *commitedQuery = [self.campaign.committed query];
    
    [commitedQuery whereKey:@"username" equalTo:[PFUser currentUser].username];
    
    [commitedQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (![objects isEqualToArray:@[]])
        {
            self.userToBeRemovedOrAdded = objects[0];
            self.decisionSwitch.on = YES;
            self.joined = YES;
        }
        else
        {
            self.decisionSwitch.on = NO;
            self.joined = NO;
        }
        
    }];
}


#pragma mark - UIButton Actions

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


- (void)seePeopleCommittedTapped
{
    NSLog(@"pressed");
    
    PFQuery *query = [self.campaign.committed query];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        DVYCommittedFriendsCollectionViewController *friendsCollectionView = [[DVYCommittedFriendsCollectionViewController alloc] initWithNibName:@"DVYCommittedFriendsCollectionViewController" bundle:nil];
        
        friendsCollectionView.committedUsers = objects;
        
        [self presentViewController:friendsCollectionView animated:YES completion:nil];
        
    }];
    
}

@end
