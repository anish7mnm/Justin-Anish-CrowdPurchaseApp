//
//  DVYInviteFriendsTableViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/25/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYInviteFriendsTableViewController.h"
#import "DVYParseAPIClient.h"
#import "InviteFriendsTableViewCell.h"
#import "DVYDataStore.h"
#import "DVYUser.h"
#import "DVYCampaign.h"

@interface DVYInviteFriendsTableViewController ()
@property(nonatomic) DVYDataStore *localDataStore;
@end

@implementation DVYInviteFriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.localDataStore = [DVYDataStore sharedLocationsDataStore];
    self.friendsSelected = [[NSMutableArray alloc] init];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.localDataStore getFacebookFriendsWithCompletionBlock:^{
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.localDataStore.friends count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InviteFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inviteFriendCell" forIndexPath:indexPath];
    
    DVYUser *friend = self.localDataStore.friends[indexPath.row];
    
    cell.friendName.text = friend[@"fullName"];
    
    NSString *userProfilePhotoURLString = friend[@"profilePicture"];
    
    if (userProfilePhotoURLString) {
        NSURL *pictureURL = [NSURL URLWithString:userProfilePhotoURLString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:pictureURL];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                   if (connectionError == nil && data != nil) {
                                       cell.profilePic.image = [UIImage imageWithData:data];
                                       
                                       // Add a nice corner radius to the image
                                       cell.profilePic.layer.cornerRadius = 8.0f;
                                       cell.profilePic.layer.masksToBounds = YES;
                                   } else {
                                       NSLog(@"Failed to load profile photo.");
                                   }
                               }];
    }

    
    
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
    DVYUser *friend = self.localDataStore.friends[indexPath.row];
    [self.friendsSelected addObject:friend];
    
}


//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 70;
//}

- (IBAction)doneButtonTapped:(id)sender {
    
    PFRelation *relation = [self.campaign relationForKey:@"invitees"];
    for (DVYUser *userFriend in self.friendsSelected) {
        [relation addObject:userFriend];
    }
    [self.campaign saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self dismissViewControllerAnimated:YES completion:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done"
                                                        message:@"Invite sent!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];
    
    
}

@end
