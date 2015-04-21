//
//  SearchDvvyUsersViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 4/19/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <Parse/Parse.h>

#import "SearchDvvyUsersViewController.h"
#import "SWRevealViewController.h"
#import "FriendsTableViewCell.h"

#import "DVYBasicAPIClient.h"

#import "DVYUser.h"


@interface SearchDvvyUsersViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonItem;

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (weak, nonatomic) IBOutlet UITableView *friendsTableView;

- (IBAction)searchButtonTapped:(id)sender;

@property (nonatomic) NSArray *users;

@end


@implementation SearchDvvyUsersViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.friendsTableView.dataSource = self;
    self.friendsTableView.delegate = self;
    self.searchTextField.delegate = self;
    
    [self.friendsTableView registerNib:[UINib nibWithNibName:@"FriendsTableViewCell" bundle:nil] forCellReuseIdentifier:@"friendsCell"];

    
    SWRevealViewController *revealViewController = self.revealViewController;
    
    if ( revealViewController )
    {
        [self.barButtonItem setTarget: self.revealViewController];
        [self.barButtonItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    }
    
}


#pragma mark - UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.users count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendsCell" forIndexPath:indexPath];
    
    DVYUser *user = self.users[indexPath.row];
    
    cell.friendsNameLabel.text = user[@"fullName"];
    
    NSString *userProfilePhotoURLString = user[@"profilePicture"];
    
    
    [DVYBasicAPIClient fetchingImageFromUserProfilePictureLinkString:userProfilePhotoURLString withSuccessBlock:^(NSData *imageData) {
        
        cell.friendsPic.image = [UIImage imageWithData:imageData];
        
    } failureBlock:^{
        
        cell.friendsPic.image = [UIImage imageNamed:@"default"];
    }];
    
    
    return cell;
    
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - UIButton Actions

- (IBAction)searchButtonTapped:(id)sender
{
    
    if (!self.searchTextField.text)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                        message:@"Please enter a valid name"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }else
    {
        PFQuery *query = [PFUser query];
        
        NSString *username = [self.searchTextField.text capitalizedString];
        
        [query whereKey:@"fullName" containsString:username];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            self.users = objects;
            if (!objects) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                                message:@"We couldn't find anyone with that name"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }else
            {
                [self.friendsTableView reloadData];
            }
        }];
        
    }
}


@end
