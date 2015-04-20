//
//  DVYSelfCampaignViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/25/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//


//Importing Frameworks
#import <JNWSpringAnimation/JNWSpringAnimation.h>
#import <NSValue+JNWAdditions.h>
#import <Parse/Parse.h>

//Importing Support Classes
#import "DVYCampaignDetailView.h"
#import "UIImage+animatedGIF.h"

//Importing Models
#import "DVYCampaign.h"
#import "Item.h"

//Importing View Controllers
#import "DVYCreateCampaignViewController.h"
#import "DVYInviteFriendsTableViewController.h"
#import "DVYSelfCampaignViewController.h"
#import "DVYHomePageViewController.h"
#import "DVYCommittedFriendsCollectionViewController.h"



@interface DVYSelfCampaignViewController ()

@property (nonatomic) DVYCampaignDetailView *detailCampaignViewSelf;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (weak, nonatomic) IBOutlet UIButton *editButton;

@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIView *backgroundBlurView;

- (IBAction)editButtinTapped:(id)sender;

@end


@implementation DVYSelfCampaignViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.opaque = NO;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self settingDetailCampaignViewInSelfCampaignViewController];
    
    self.detailCampaignViewSelf.campaignTitle.text = [self.campaign.title capitalizedString];
    
    self.detailCampaignViewSelf.campaignDetails.text = self.campaign.detail;
    
    self.detailCampaignViewSelf.peopleNeeded.text = [NSString stringWithFormat:@"%@", self.campaign.minimumNeededCommits];
    
    [self displayingHostName];
    
    [self displayingDeadline];
    
    [self displayingPeopleCommittedCount];
}



#pragma mark - View Helper Methods

- (void)settingDetailCampaignViewInSelfCampaignViewController
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"DVYCampaignDetailView" owner:self options:nil];
    
    self.detailCampaignViewSelf = [nibViews firstObject];
    
    self.detailCampaignViewSelf.selfCampaignVC = self;
    
    [self.detailCampaignViewSelf buttonAction];
    
    Item *campaignItem = self.campaign.item;
    PFFile *image = [campaignItem objectForKey:@"itemImage"];
    
    if (image)
    {
        [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
        {
            if (!error)
            {
                
                self.detailCampaignViewSelf.profilePicture.image = [UIImage imageWithData:data];
                
                self.detailCampaignViewSelf.profilePicture.layer.masksToBounds = YES;
            }
            
        }];
        
    } else
    {
        NSURL *pusheenDance = [NSURL URLWithString:@"http://33.media.tumblr.com/tumblr_m9hbpdSJIX1qhy6c9o1_400.gif"];
        
        self.detailCampaignViewSelf.profilePicture.image = [UIImage animatedImageWithAnimatedGIFURL:pusheenDance];
        
        self.detailCampaignViewSelf.profilePicture.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    self.detailCampaignViewSelf.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.detailCampaignViewSelf];
    
    self.detailCampaignViewSelf.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
    self.detailCampaignViewSelf.neededCountView.layer.cornerRadius = 8.0f;
    self.detailCampaignViewSelf.commitCountView.layer.cornerRadius = 8.0f;
}


- (void)displayingHostName
{
    DVYUser *host = self.campaign.host;
    
    self.detailCampaignViewSelf.hostName.text = [NSString stringWithFormat:@"Made by: %@", host[@"fullName"]];

}


- (void)displayingDeadline
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"MM/dd/yy"];
    
    NSString *stringDate = [dateFormatter stringFromDate:self.campaign.deadline];
    
    self.detailCampaignViewSelf.deadline.text = stringDate;
}


- (void)displayingPeopleCommittedCount
{
    PFQuery *query = [self.campaign.committed query];
    
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error)
    {
        NSInteger count = (NSInteger) number;
        self.detailCampaignViewSelf.peopleCommited.text = [NSString stringWithFormat:@"%ld", count];
    }];

}


- (void)blurTheView
{
    self.view.backgroundColor = [UIColor clearColor];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurredEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurredEffectView.frame = self.view.frame;
    [self.backgroundBlurView addSubview:blurredEffectView];
}



#pragma mark - UIButton Actions

- (IBAction)editButtinTapped:(id)sender {
    
    DVYCreateCampaignViewController *edit = [[DVYCreateCampaignViewController alloc] init];
    
    edit.buttonName = @"Update";
    edit.titlePlaceholder = self.campaign.title;
    edit.descriptionPlaceholder = self.campaign.detail;
    edit.numberOfPeoplePlaceHolder = [NSString stringWithFormat:@"%@", self.campaign.minimumNeededCommits];
    edit.campaignToUpdate = self.campaign;
    
    edit.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:edit animated:YES completion:nil];
    
}


- (IBAction)addFriendsButtinTapped:(id)sender {
    
    UIStoryboard *myStoryboard = [UIStoryboard storyboardWithName:@"CreateFlow" bundle:nil];
    
    DVYInviteFriendsTableViewController *friendsToBeAdded = [myStoryboard instantiateInitialViewController];
    friendsToBeAdded.campaign = self.campaign;
    
    [self presentViewController:friendsToBeAdded animated:YES completion:nil];
    
}


- (IBAction)doneButtonTapped:(id)sender {
    
    DVYHomePageViewController *homeVC = (DVYHomePageViewController *)self.presentingViewController.childViewControllers[0];
    
    [homeVC refresh];

    [self dismissViewControllerAnimated:YES completion:nil];

}


- (IBAction)deleteButtonTapped:(id)sender {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Hey DVVY user"
                                          message:@"Are You sure you want to delete this Campaign?"
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                       
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK action");
                                   
                                   Item *campaignItem = self.campaign.item;
                                   
                                   [campaignItem deleteInBackground];
                                   
                                   [self.campaign deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                       
                                       DVYHomePageViewController *homeVC = (DVYHomePageViewController *)self.presentingViewController.childViewControllers[0];
                                       
                                       [homeVC refresh];
                                       
                                       [self dismissViewControllerAnimated:YES completion:nil];
                                   }];

                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
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



#pragma mark - Constriants

- (void)removeConstraints
{
    [self.view removeConstraints:self.view.constraints];
    
    self.detailCampaignViewSelf.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.buttonView removeConstraints:self.buttonView.constraints];
    self.buttonView.translatesAutoresizingMaskIntoConstraints = NO;
}


- (void)setConstraints
{
   
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.presentingViewController attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-16];
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.presentingViewController attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.presentingViewController attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.presentingViewController attribute:NSLayoutAttributeTop multiplier:0 constant:100];
    
    [self.view addConstraints:@[width, centerX, centerY, height]];
    
}


@end
