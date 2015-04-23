//
//  DVYInviteFriendsTableViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/25/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYBasicAPIClient.h"
#import "DVYDataStore.h"
#import "DVYInviteFriendsTableViewController.h"
#import "InviteFriendsTableViewCell.h"
#import "DVYUser.h"
#import "DVYCampaign.h"

//Importing AddressBook for sending text invitation to Phonebook friends
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>



@interface DVYInviteFriendsTableViewController () <UITableViewDataSource, UITableViewDelegate>


@property(nonatomic) DVYDataStore *localDataStore;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) UIColor *backColor;

@property (weak, nonatomic) IBOutlet UIButton *inviteButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;


@end



@implementation DVYInviteFriendsTableViewController


#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.localDataStore = [DVYDataStore sharedLocationsDataStore];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    self.friendsSelected = [[NSMutableArray alloc] init];
    
    self.inviteButton.layer.cornerRadius = 4.0f;
    self.cancelButton.layer.cornerRadius = 4.0f;

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    [self.localDataStore getFacebookFriendsWithCompletionBlock:^{
        [self.tableView reloadData];
    }];

}


#pragma mark - UITableViewDataSource Methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.localDataStore.friends count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InviteFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inviteFriendCell" forIndexPath:indexPath];
    
    DVYUser *friend = self.localDataStore.friends[indexPath.row];
    
    cell.friendName.text = friend[@"fullName"];
    
    cell.profilePic.image = [UIImage imageNamed:@"default"];

    // Add a nice corner radius to the image
    cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2;
    cell.profilePic.layer.masksToBounds = YES;

    NSString *userProfilePhotoURLString = friend[@"profilePicture"];
    
    if (userProfilePhotoURLString)
    {
       
        [DVYBasicAPIClient fetchingImageFromUserProfilePictureLinkString:userProfilePhotoURLString withSuccessBlock:^(NSData *imageData) {
            
            cell.profilePic.image = [UIImage imageWithData:imageData];

        } failureBlock:^{
            
            cell.profilePic.image = [UIImage imageNamed:@"default"];
        
        }];
        
    }
    else
    {
        cell.profilePic.image = [UIImage imageNamed:@"default"];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    self.backColor = cell.backgroundColor;
    
    cell.highlighted = NO;

    
    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView
                                    cellForRowAtIndexPath:indexPath];

    //UIImageView *checkmark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check"]];


    DVYUser *friend = self.localDataStore.friends[indexPath.row];

    if(cell.accessoryType == UITableViewCellAccessoryCheckmark)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.friendsSelected removeObject:friend];
    }
    
    else
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.backgroundColor = [UIColor clearColor];
        [self.friendsSelected addObject:friend];

    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (IBAction)doneButtonTapped:(id)sender
{
    
    PFRelation *relation = [self.campaign relationForKey:@"invitees"];
    
    for (DVYUser *userFriend in self.friendsSelected)
    {
        [relation addObject:userFriend];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [self.campaign saveInBackground];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done"
                                                        message:@"Invite sent!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }];
    
}


- (IBAction)cancelButtonTapped:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];

}


- (IBAction)addFromContacts:(id)sender
{
    
    
    
}

@end
