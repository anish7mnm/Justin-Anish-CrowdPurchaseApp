//
//  DVYHomePageViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/20/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <Parse/Parse.h>
#import "DVYHomePageViewController.h"
#import "DVYDataStore.h"
#import "DVYTableViewCell.h"
#import "DVYFacebookLoginViewController.h"

@interface DVYHomePageViewController ()
@property (strong, nonatomic) DVYDataStore *localDataStore;
@property (strong, nonatomic) PFUser *currentUser;
@property (weak, nonatomic) IBOutlet UIButton *selfButton;
@property (weak, nonatomic) IBOutlet UIButton *othersButton;
@property (weak, nonatomic) IBOutlet UIButton *invitesButton;
@property (strong, nonatomic) DVYFacebookLoginViewController *facebookLogin;

@end

@implementation DVYHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentUser = [PFUser currentUser];
    
    self.selfTableView.delegate=self;
    self.selfTableView.dataSource = self;
    self.othersTableView.delegate=self;
    self.othersTableView.dataSource=self;
    self.invitationTableView.delegate=self;
    self.invitationTableView.dataSource=self;
    
    self.localDataStore = [DVYDataStore sharedLocationsDataStore];
    [self.selfTableView setAccessibilityIdentifier:@"forSelfCampaign"];
    [self.othersTableView setAccessibilityIdentifier:@"forOthersCampaign"];
    [self.invitationTableView setAccessibilityIdentifier:@"invitations"];
    
    [self removeAllConstraints];
    [self settingConstraints];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if ([tableView.accessibilityIdentifier isEqualToString:@"forSelfCampaign"]) {
//        return [self.localDataStore.selfCampaigns count];
//    }
//    else if ([tableView.accessibilityIdentifier isEqualToString:@"forOthersCampaign"]) {
//        return [self.localDataStore.othersCampaign count];
//    }
//    else {
//        return [self.localDataStore.alertCampaign count];
//    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView.accessibilityIdentifier isEqualToString:@"forSelfCampaign"])
    {
        DVYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selfCampaignCell" forIndexPath:indexPath];
        
        cell.campaignTitle.text = @"Design+Code Book";
        cell.hostName.text = @"6";
        cell.hostName.textColor = [UIColor purpleColor];
        
        cell.campaignImagePicture.image = [UIImage imageNamed:@"book"];
        return cell;
        
    }
    
    else if ([tableView.accessibilityIdentifier isEqualToString:@"forOthersCampaign"])
    {
        DVYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"othersCampaignCell" forIndexPath:indexPath];

        cell.campaignTitle.text = @"Park Tickets";
        cell.hostName.text = @"Justin Kim";
        cell.hostName.textColor = [UIColor grayColor];
        
        cell.campaignImagePicture.image = [UIImage imageNamed:@"amus.jpg"];
        return cell;
        
    }
    
    else
    {
        DVYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"invitationCell" forIndexPath:indexPath];
        
        cell.campaignTitle.text = @"sdsf";

        return cell;
        
    }
    
}

- (void) removeAllConstraints
{
    [self.view removeConstraints:self.view.constraints];

    [self.scrollView removeConstraints:self.scrollView.constraints];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView removeConstraints:self.containerView.constraints];
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.selfTableView removeConstraints:self.selfTableView.constraints];
    self.selfTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.othersTableView removeConstraints:self.othersTableView.constraints];
    self.othersTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.invitationTableView removeConstraints:self.invitationTableView.constraints];
    self.invitationTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.buttonView removeConstraints:self.buttonView.constraints];
    self.buttonView.translatesAutoresizingMaskIntoConstraints=NO;
    [self.selfButton removeConstraints:self.selfButton.constraints];
    self.selfButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.othersButton removeConstraints:self.othersButton.constraints];
    self.othersButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.invitesButton removeConstraints:self.invitesButton.constraints];
    self.invitesButton.translatesAutoresizingMaskIntoConstraints = NO;

}

- (void) settingConstraints
{
    
    
    
    NSLayoutConstraint *scrollViewLeftMArgin =
    [NSLayoutConstraint constraintWithItem:self.scrollView
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0.0];
    
    [self.view addConstraint:scrollViewLeftMArgin];
    
    NSLayoutConstraint *scrollViewRightMargin =
    [NSLayoutConstraint constraintWithItem:self.scrollView
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0.0];
    
    [self.view addConstraint:scrollViewRightMargin];
    
    NSLayoutConstraint *scrollViewX =
    [NSLayoutConstraint constraintWithItem:self.scrollView
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0.0];
    
    [self.view addConstraint:scrollViewX];
    
    NSLayoutConstraint *buttonViewWidth =
    [NSLayoutConstraint constraintWithItem:self.buttonView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0.0];
    
    [self.view addConstraint:buttonViewWidth];
    
    NSLayoutConstraint *buttonViewHeight =
    [NSLayoutConstraint constraintWithItem:self.buttonView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeHeight
                                multiplier:0.10
                                  constant:0.0];
    
    [self.view addConstraint:buttonViewHeight];
    
    
    NSDictionary *views = @{@"containerView":self.containerView,
                            @"table1":self.selfTableView,
                            @"table2":self.othersTableView,
                            @"table3":self.invitationTableView,
                            @"scrollView":self.scrollView,
                            @"buttonView":self.buttonView,
                            @"selfButton":self.selfButton,
                            @"othersButton":self.othersButton,
                            @"inviteButton":self.invitesButton};
    
    NSArray *topBottomView = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[buttonView]-[scrollView]|" options:0 metrics:nil views:views];
    [self.view addConstraints:topBottomView];
    
    NSArray *buttonsLeftToRight = [NSLayoutConstraint constraintsWithVisualFormat:@"|[selfButton][othersButton(==selfButton)][inviteButton(==selfButton)]|" options:0 metrics:nil views:views];
    [self.buttonView addConstraints:buttonsLeftToRight];
    
    NSLayoutConstraint *selfButtonHeight =
    [NSLayoutConstraint constraintWithItem:self.selfButton
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.buttonView
                                 attribute:NSLayoutAttributeHeight
                                multiplier:1.0
                                  constant:0.0];
    
    [self.buttonView addConstraint:selfButtonHeight];
    
    NSLayoutConstraint *othersButtonHeight =
    [NSLayoutConstraint constraintWithItem:self.othersButton
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.buttonView
                                 attribute:NSLayoutAttributeHeight
                                multiplier:1.0
                                  constant:0.0];
    
    [self.buttonView addConstraint:othersButtonHeight];
    
    NSLayoutConstraint *inviteButtonHeight =
    [NSLayoutConstraint constraintWithItem:self.invitesButton
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.buttonView
                                 attribute:NSLayoutAttributeHeight
                                multiplier:1.0
                                  constant:0.0];
    
    [self.buttonView addConstraint:inviteButtonHeight];
    
    
    NSArray *leftRightContent = [NSLayoutConstraint constraintsWithVisualFormat:@"|[containerView]|" options:0 metrics:nil views:views];
    NSArray *topBottomContent = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[containerView]|" options:0 metrics:nil views:views];
    
    [self.scrollView addConstraints:leftRightContent];
    [self.scrollView addConstraints:topBottomContent];
    
    
    NSArray *horizontalTables =
    [NSLayoutConstraint constraintsWithVisualFormat:@"|[table1(==scrollView)][table2(==table1)][table3(==table1)]|"
                                            options:0
                                            metrics:nil
                                              views:views];
    
    [self.scrollView addConstraints:horizontalTables];
    
    NSArray *table1Vertical =
    [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[table1(==scrollView)]|"
                                            options:0
                                            metrics:nil
                                              views:views];
    [self.scrollView addConstraints:table1Vertical];
    NSArray *table2Vertical =
    [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[table2]|"
                                            options:0
                                            metrics:nil
                                              views:views];
    [self.containerView addConstraints:table2Vertical];
    NSArray *table3Vertical =
    [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[table3]|"
                                            options:0
                                            metrics:nil
                                              views:views];
    [self.containerView addConstraints:table3Vertical];
    self.scrollView.pagingEnabled = YES;

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