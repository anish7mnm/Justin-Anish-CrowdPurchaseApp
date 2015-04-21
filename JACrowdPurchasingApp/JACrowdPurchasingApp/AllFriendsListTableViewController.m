//
//  AllFriendsListTableViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 4/20/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "AllFriendsListTableViewController.h"
#import "SWRevealViewController.h"
#import "FriendsTableViewCell.h"

#import "DVYDataStore.h"
#import "DVYBasicAPIClient.h"
#import "DVYUser.h"


@interface AllFriendsListTableViewController ()

@property (nonatomic) DVYDataStore *localDataStore;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonItem;

@end


@implementation AllFriendsListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    
    if ( revealViewController )
    {
        [self.barButtonItem setTarget: self.revealViewController];
        [self.barButtonItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    }
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendsTableViewCell" bundle:nil] forCellReuseIdentifier:@"friendsCell"];
    
    self.localDataStore = [DVYDataStore sharedLocationsDataStore];
    
    [self.localDataStore getFacebookFriendsWithCompletionBlock:^{
        [self.tableView reloadData];
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.localDataStore.friends count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendsCell" forIndexPath:indexPath];
    
    DVYUser *friend = self.localDataStore.friends[indexPath.row];
    
    cell.friendsNameLabel.text = friend[@"fullName"];
    
    NSString *userProfilePhotoURLString = friend[@"profilePicture"];
    
    [DVYBasicAPIClient fetchingImageFromUserProfilePictureLinkString:userProfilePhotoURLString withSuccessBlock:^(NSData *imageData) {
        
        cell.friendsPic.image = [UIImage imageWithData:imageData];
        
    } failureBlock:^{
        
        cell.friendsPic.image = [UIImage imageNamed:@"default"];
    }];
    
    return cell;
}


@end
