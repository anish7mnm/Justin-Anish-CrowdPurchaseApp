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

}


-(void)viewDidAppear:(BOOL)animated
{

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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



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
