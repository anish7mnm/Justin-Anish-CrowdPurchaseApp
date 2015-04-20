//
//  HamburgerMenuViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 4/19/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <Parse/Parse.h>

#import "DVYBasicAPIClient.h"

#import "HamburgerMenuViewController.h"
#import "SWRevealViewController.h"
#import "DVYFacebookLoginViewController.h"

@interface HamburgerMenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userProfilePicture;

@property (weak, nonatomic) IBOutlet UILabel *userFullName;

@property (weak, nonatomic) IBOutlet UITableView *menuListTableView;

@end


@implementation HamburgerMenuViewController

NSArray *menuItems;


#pragma mark - View Lifecycle

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    [self settingUserProfilePictureAndName];
    
    self.menuListTableView.delegate = self;
    self.menuListTableView.dataSource = self;
    
    menuItems = @[@"home", @"search", @"friends", @"settings", @"logout"];

}


#pragma mark - View Helper Methods

- (void)settingUserProfilePictureAndName
{
    self.userProfilePicture.layer.cornerRadius = self.userProfilePicture.frame.size.width / 2;
    
    self.userProfilePicture.layer.masksToBounds = YES;
    
    NSString *userProfilePhotoURLString = [PFUser currentUser][@"profilePicture"];
    
    [DVYBasicAPIClient fetchingImageFromUserProfilePictureLinkString:userProfilePhotoURLString withSuccessBlock:^(NSData *imageData) {
        
        self.userProfilePicture.image = [UIImage imageWithData:imageData];
        
    } failureBlock:^{
        
        self.userProfilePicture.image = [UIImage imageNamed:@"default"];
    }];
    
    self.userFullName.text = [PFUser currentUser][@"fullName"];
}


#pragma mark - UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}


#pragma mark - UITableViewDataSource Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[menuItems objectAtIndex:indexPath.row] isEqualToString: @"logout"])
    {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Hey DVVY user"
                                              message:@"Are you sure you want to Log out?"
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *noAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"NO", @"NO action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"NO action");
                                           
                                       }];
        
        UIAlertAction *yesAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"YES", @"YES action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"YES action");
                                       
                                       [PFUser logOut];
                                       PFUser *currentUser = [PFUser currentUser];
                                       
                                       DVYFacebookLoginViewController *introPage = [[DVYFacebookLoginViewController alloc] init];
                                       
                                       [self presentViewController:introPage animated:YES completion:nil];
                                       
                                   }];
        
        [alertController addAction:noAction];
        [alertController addAction:yesAction];
        
        [self presentViewController:alertController animated:YES completion:nil];

    }
}


@end
