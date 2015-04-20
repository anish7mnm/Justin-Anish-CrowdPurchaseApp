//
//  HamburgerMenuViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 4/19/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <Parse/Parse.h>

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


- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    self.menuListTableView.delegate = self;
    self.menuListTableView.dataSource = self;
    
    menuItems = @[@"home", @"search", @"friends", @"settings", @"logout"];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
