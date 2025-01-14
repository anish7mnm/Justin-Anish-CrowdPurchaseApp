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

#import "DVYOtherCampaignViewController.h"
#import "DVYSelfCampaignViewController.h"
#import "DVYCreateCampaignViewController.h"
#import "DVYCommittedFriendsCollectionViewController.h"
#import "SWRevealViewController.h"

#import "UIColor+dvvyColors.h"
#import "UIImage+animatedGIF.h"


@interface DVYHomePageViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) DVYDataStore *localDataStore;

@property (strong, nonatomic) PFUser *currentUser;

@property (weak, nonatomic) IBOutlet UIButton *selfButton;

@property (weak, nonatomic) IBOutlet UIButton *othersButton;

@property (weak, nonatomic) IBOutlet UIButton *invitesButton;

@property (nonatomic) UIRefreshControl *refreshControl;

@property (nonatomic) UIRefreshControl *othersRefreshControl;

@property (nonatomic) UIRefreshControl *invitationRefreshControl;

@property (nonatomic) UIImageView *icon1;

@property (nonatomic) UIImageView *icon2;

@property (nonatomic) UIImageView *icon3;

@property (nonatomic) SWRevealViewController *hamburgerMenu;

@end



@implementation DVYHomePageViewController


#pragma mark - View Lifecycle

//CONFUSED
- (void)presentCollectionView
{
    NSLog(@"pressed");
    DVYCommittedFriendsCollectionViewController *friendsCollectionView = [[DVYCommittedFriendsCollectionViewController alloc] initWithNibName:@"DVYCommittedFriendsCollectionViewController" bundle:nil];
    
    [self presentViewController:friendsCollectionView animated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentUser = [PFUser currentUser];
    
    self.localDataStore = [DVYDataStore sharedLocationsDataStore];
    
    self.scrollView.delegate = self;
    
    [self settingUpTheThreeTableViews];
    
    [self removeAllConstraints];
    [self settingConstraints];
    
    [self addingPullToRefreshFeatureToTheTableViews];
    
    [self addingSideIconsToTheButtons];
    
    [self settingTableViewBackgroundColor];
    
    [self settingUpTheHamburgerMenu];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"background.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    [self removeShadowUnderNavBar];
}


-(void)viewDidAppear:(BOOL)animated
{
    [self initialButtonHighlight];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self fillingTheTableViewsWithData];
}



#pragma mark - UITableView Setup

- (void)settingUpTheThreeTableViews
{
    
    self.selfTableView = [[UITableView alloc] initWithFrame:self.scrollView.frame];
    self.othersTableView = [[UITableView alloc] initWithFrame:self.scrollView.frame];
    self.invitationTableView = [[UITableView alloc] initWithFrame:self.scrollView.frame];
    
    [self.selfTableView registerNib:[UINib nibWithNibName:@"DVYTableViewCell" bundle:nil] forCellReuseIdentifier:@"selfCampaignCell"];
    [self.othersTableView registerNib:[UINib nibWithNibName:@"DVYTableViewCell" bundle:nil] forCellReuseIdentifier:@"othersCampaignCell"];
    [self.invitationTableView registerNib:[UINib nibWithNibName:@"DVYTableViewCell" bundle:nil] forCellReuseIdentifier:@"invitationCampaignCell"];
    
    [self.containerView addSubview:self.selfTableView];
    [self.containerView addSubview:self.othersTableView];
    [self.containerView addSubview:self.invitationTableView];
    
    self.selfTableView.delegate=self;
    self.selfTableView.dataSource=self;
    self.othersTableView.delegate=self;
    self.othersTableView.dataSource=self;
    self.invitationTableView.delegate=self;
    self.invitationTableView.dataSource=self;
    
    self.selfTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.othersTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.invitationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.selfTableView) {
        return [self.localDataStore.selfCampaigns count];
    }
    else if (tableView == self.othersTableView) {
        return [self.localDataStore.othersCampaign count];
    }
    else {
        return [self.localDataStore.alertCampaign count];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.selfTableView)
    {
        DVYTableViewCell *cell = [self.selfTableView dequeueReusableCellWithIdentifier:@"selfCampaignCell" forIndexPath:indexPath];
        
        DVYCampaign *selfCampaign = self.localDataStore.selfCampaigns[indexPath.row];
        cell.cellCampaign = selfCampaign;
        
        //cell.campaignTitle.text = [selfCampaign.title uppercaseString];
        
        DVYUser *myself = (DVYUser *)[PFUser currentUser];
        
        cell.hostName.text = [NSString stringWithFormat:@"Made by: %@", [myself objectForKey:@"fullName"]];
        
        return cell;
    
    }
    
    else if (tableView == self.othersTableView)
    {
        DVYTableViewCell *cell = [self.othersTableView dequeueReusableCellWithIdentifier:@"othersCampaignCell" forIndexPath:indexPath];
        
        DVYCampaign *othersCampaign = self.localDataStore.othersCampaign[indexPath.row];
        cell.cellCampaign = othersCampaign;
        
        return cell;
        
    }
    
    else
    {
        DVYTableViewCell *cell = [self.invitationTableView dequeueReusableCellWithIdentifier:@"invitationCampaignCell" forIndexPath:indexPath];
        
        DVYCampaign *othersCampaign = self.localDataStore.alertCampaign[indexPath.row];
        cell.cellCampaign = othersCampaign;
        
        return cell;
        
    }
    
}



#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.selfTableView) {
        
        DVYSelfCampaignViewController *selfCampaign = [[DVYSelfCampaignViewController alloc] initWithNibName:@"DVYSelfCampaignViewController" bundle:nil];
        
        DVYCampaign *campaignToPass = self.localDataStore.selfCampaigns[indexPath.row];
        selfCampaign.campaign = campaignToPass;
        
        selfCampaign.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        selfCampaign.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        [self presentViewController:selfCampaign animated:YES completion:nil];
    }
    
    else if (tableView == self.othersTableView) {
        
        DVYOtherCampaignViewController *othersCampaign = [[DVYOtherCampaignViewController alloc] init];
        
        DVYCampaign *campaignToPass = self.localDataStore.othersCampaign[indexPath.row];
        othersCampaign.campaign = campaignToPass;
        
        othersCampaign.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        othersCampaign.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        [self presentViewController:othersCampaign animated:YES completion:nil];
        
    }
    
    else if (tableView == self.invitationTableView) {
        
        DVYOtherCampaignViewController *othersCampaignInvite = [[DVYOtherCampaignViewController alloc] init];
        
        DVYCampaign *campaignToPass = self.localDataStore.alertCampaign[indexPath.row];
        othersCampaignInvite.campaign = campaignToPass;
        
        othersCampaignInvite.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        othersCampaignInvite.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        [self presentViewController:othersCampaignInvite animated:YES completion:nil];
    }
    
}



#pragma mark - UITableView Helper Methods

- (void)fillingTheTableViewsWithData
{
    [self.localDataStore getselfCampaignsWithCompletionBlock:^{
        
        NSLog(@"Got the campaigns hosted by me");
        
        if (self.refreshControl) {
            [self.refreshControl endRefreshing];
        }
        
        [self.selfTableView reloadData];
    }];
    
    [self.localDataStore getOtherCampaignsWithCompletionBlock:^{
        
        NSLog(@"Got the campaigns hosted by others");
        
        if (self.othersRefreshControl) {
            [self.othersRefreshControl endRefreshing];
        }
        
        [self.othersTableView reloadData];
    }];
    
    [self.localDataStore getInvitiationCampaignsWithCompletionBlock:^{
        
        if (self.invitationRefreshControl) {
            [self.invitationRefreshControl endRefreshing];
        }
        
        [self.invitationTableView reloadData];
        
        NSLog(@"Got the campaigns invites");
    }];
}


- (void)addingPullToRefreshFeatureToTheTableViews {
    
    //Pull to refresh for tableviews
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.selfTableView addSubview:self.refreshControl];
    
    self.othersRefreshControl = [[UIRefreshControl alloc] init];
    [self.othersRefreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.selfTableView addSubview:self.othersRefreshControl];
    
    self.invitationRefreshControl = [[UIRefreshControl alloc] init];
    [self.invitationRefreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.selfTableView addSubview:self.invitationRefreshControl];
    
    [self.othersTableView addSubview:self.othersRefreshControl];
    [self.invitationTableView addSubview:self.invitationRefreshControl];
}


- (void)refresh
{
    // do your refresh here and reload the tablview
    [self viewWillAppear:YES];
}


- (void)settingTableViewBackgroundColor {
    // self.selfTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    
    self.selfTableView.backgroundColor = [UIColor dvvyLightGrey];
    self.othersTableView.backgroundColor = [UIColor dvvyLightGrey];
    self.invitationTableView.backgroundColor = [UIColor dvvyLightGrey];
}



#pragma mark - Constraints

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
    NSLayoutConstraint *scrollViewTopToButtonViewBottom =
    [NSLayoutConstraint constraintWithItem:self.scrollView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.buttonView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0.0];
    
    [self.view addConstraint:scrollViewTopToButtonViewBottom];
    
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
                                multiplier:0.05
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
    
    NSArray *topBottomView = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[buttonView][scrollView]|" options:0 metrics:nil views:views];
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



#pragma mark - UIButton Actions

- (IBAction)createACampaign:(id)sender
{
    DVYCreateCampaignViewController *createCampaign = [[DVYCreateCampaignViewController alloc] init];
    
    createCampaign.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    createCampaign.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:createCampaign animated:YES completion:nil];
}


- (IBAction)seeSelfCampaignTableButton:(id)sender
{
    [self highlightingSelfButton];
    
    CGPoint newOffset =CGPointMake(0, self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:NO];
}


- (IBAction)seeOthersCampaignTableButton:(id)sender
{
    [self highlightingOthersButton];
    
    CGFloat scrollViewWidth = self.scrollView.frame.size.width;
    CGPoint newOffset =CGPointMake(scrollViewWidth, self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:NO];
}


- (IBAction)seeInvitesTableButton:(id)sender
{
    [self highlightingInviteButton];
    
    CGFloat scrollViewWidth = self.scrollView.frame.size.width;
    CGPoint newOffset =CGPointMake(scrollViewWidth*2, self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:NO];
}



#pragma mark - UINavigationBar modification

- (void) makingNavBarSexy
{
    
    UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, self.navigationController.navigationBar.frame.origin.y,150,20)];
    navLabel.text = [NSString stringWithFormat:@"Hi %@", self.currentUser[@"fullName"]];
    navLabel.textColor = [UIColor purpleColor];
    [navLabel setFont:[UIFont systemFontOfSize:12.0]];
    //[naviBarObj addSubview:navLabel];
    [navLabel setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar addSubview:navLabel];
    
    NSString *userProfilePhotoURLString = self.currentUser[@"profilePicture"];
    
    if (userProfilePhotoURLString) {
        NSURL *pictureURL = [NSURL URLWithString:userProfilePhotoURLString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:pictureURL];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                   if (connectionError == nil && data != nil) {
                                       UIImageView *pic = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
                                       [pic setFrame:CGRectMake(self.navigationController.navigationBar.frame.origin.x,self.navigationController.navigationBar.frame.origin.y -10,30,30)];
                                       [pic setBackgroundColor:[UIColor clearColor]];
                                       pic.layer.cornerRadius = pic.frame.size.width / 2;
                                       pic.layer.masksToBounds = YES;
                                       [self.navigationController.navigationBar addSubview:pic];
                                       
                                   } else {
                                       NSLog(@"Failed to load profile photo.");
                                   }
                               }];
        
    }
}


- (void)removeShadowUnderNavBar
{
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"bgShadow"]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    
    [navigationBar setShadowImage:[UIImage new]];
}


-(void)settingUpTheHamburgerMenu
{
    
    self.hamburgerMenu = [self revealViewController];
    
    [self.hamburgerMenu tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStylePlain target:self.hamburgerMenu action:@selector(revealToggle:)];
    
    revealButtonItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    
}


#pragma mark - ScrollView Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==self.scrollView)
    {
        CGFloat offset = scrollView.contentOffset.x;
        NSLog(@"scrollviewOffset %f", offset);
        if (offset == 0.0)
        {
            [self highlightingSelfButton];
        }
        else if (offset == self.scrollView.frame.size.width)
        {
            [self highlightingOthersButton];
        }
        else if (offset == (2*self.scrollView.frame.size.width))
        {
            [self highlightingInviteButton];
        }
    }
}


#pragma mark - UIButton Helper Methods

- (void)highlightingSelfButton
{
    self.icon1.image = [self changeColorForImage:self.icon1.image toColor:[UIColor dvvyBlueAlternative]];
    self.icon2.image = [self changeColorForImage:self.icon2.image toColor:[UIColor dvvyDarkGrey]];
    self.icon3.image = [self changeColorForImage:self.icon3.image toColor:[UIColor dvvyDarkGrey]];
    self.selfButton.titleLabel.textColor = [UIColor dvvyBlueAlternative];
    self.invitesButton.titleLabel.textColor = [UIColor dvvyDarkGrey];
    self.othersButton.titleLabel.textColor = [UIColor dvvyDarkGrey];
}


- (void)highlightingOthersButton
{
    self.icon2.image = [self changeColorForImage:self.icon2.image toColor:[UIColor dvvyBlueAlternative]];
    self.icon1.image = [self changeColorForImage:self.icon1.image toColor:[UIColor dvvyDarkGrey]];
    self.icon3.image = [self changeColorForImage:self.icon3.image toColor:[UIColor dvvyDarkGrey]];
    self.othersButton.titleLabel.textColor = [UIColor dvvyBlueAlternative];
    self.selfButton.titleLabel.textColor = [UIColor dvvyDarkGrey];
    self.invitesButton.titleLabel.textColor = [UIColor dvvyDarkGrey];
}


- (void)highlightingInviteButton
{
    self.icon3.image = [self changeColorForImage:self.icon3.image toColor:[UIColor dvvyBlueAlternative]];
    self.icon2.image = [self changeColorForImage:self.icon2.image toColor:[UIColor dvvyDarkGrey]];
    self.icon1.image = [self changeColorForImage:self.icon1.image toColor:[UIColor dvvyDarkGrey]];
    self.invitesButton.titleLabel.textColor = [UIColor dvvyBlueAlternative];
    self.selfButton.titleLabel.textColor = [UIColor dvvyDarkGrey];
    self.othersButton.titleLabel.textColor = [UIColor dvvyDarkGrey];
}


- (void)initialButtonHighlight
{
    CGFloat offset = self.scrollView.contentOffset.x;
    if (offset == 0.0) {
        [self highlightingSelfButton];
        
    }
    else if (offset == self.scrollView.frame.size.width)
    {
        [self highlightingOthersButton];
        
    }
    else if (offset == (2*self.scrollView.frame.size.width))
    {
        [self highlightingInviteButton];
        
    }
}


- (void)addingSideIconsToTheButtons
{
    // add icons to buttons
    UIImageView *selfIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user168"]];
    selfIconView.frame = CGRectMake(20, 6, 12, 12);
    selfIconView.contentMode = UIViewContentModeScaleAspectFill;
    self.icon1 = selfIconView;
    [self.selfButton addSubview:self.icon1];
    
    UIImageView *otherIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"multiple25"]];
    otherIconView.frame = CGRectMake(17, 6, 14, 14);
    otherIconView.contentMode = UIViewContentModeScaleAspectFill;
    [self.othersButton addSubview:otherIconView];
    self.icon2 = otherIconView;
    
    UIImageView *invitesIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mail59"]];
    invitesIconView.frame = CGRectMake(14, 5, 14, 14);
    invitesIconView.contentMode = UIViewContentModeScaleAspectFill;
    [self.invitesButton addSubview:invitesIconView];
    self.icon3 = invitesIconView;
}



#pragma mark - Methods to refactor

- (UIImage *) changeColorForImage:(UIImage *)image toColor:(UIColor*)color
{
    UIGraphicsBeginImageContext(image.size);
    
    CGRect contextRect;
    contextRect.origin.x = 0.0f;
    contextRect.origin.y = 0.0f;
    contextRect.size = [image size];
    // Retrieve source image and begin image context
    CGSize itemImageSize = [image size];
    CGPoint itemImagePosition;
    itemImagePosition.x = ceilf((contextRect.size.width - itemImageSize.width) / 2);
    itemImagePosition.y = ceilf((contextRect.size.height - itemImageSize.height) );
    
    UIGraphicsBeginImageContext(contextRect.size);
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    // Setup shadow
    // Setup transparency layer and clip to mask
    CGContextBeginTransparencyLayer(c, NULL);
    CGContextScaleCTM(c, 1.0, -1.0);
    CGContextClipToMask(c, CGRectMake(itemImagePosition.x, -itemImagePosition.y, itemImageSize.width, -itemImageSize.height), [image CGImage]);
    // Fill and end the transparency layer
    
    
    const CGFloat* colors = CGColorGetComponents( color.CGColor );
    CGContextSetRGBFillColor(c, colors[0], colors[1], colors[2], 1.0);
    
    contextRect.size.height = -contextRect.size.height;
    contextRect.size.height -= 15;
    CGContextFillRect(c, contextRect);
    CGContextEndTransparencyLayer(c);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


@end
