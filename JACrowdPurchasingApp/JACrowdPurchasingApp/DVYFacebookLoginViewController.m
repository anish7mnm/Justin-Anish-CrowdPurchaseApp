//
//  DVYFacebookLoginViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/23/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYFacebookLoginViewController.h"
#import "DVYHomePageViewController.h"

#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface DVYFacebookLoginViewController ()

- (IBAction)facebookTapped:(id)sender;

@end

@implementation DVYFacebookLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Check if user is cached and linked to Facebook, if so, bypass login
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        DVYHomePageViewController *homePage = [[DVYHomePageViewController alloc] initWithNibName:@"DVYHomePageViewController" bundle:nil];
        [self presentViewController:homePage animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)facebookTapped:(id)sender {
    
    NSArray *permissionsArray = @[ @"email", @"user_friends"];
    
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        [_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user)
        {
            NSString *errorMessage = nil;
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                errorMessage = @"Uh oh. The user cancelled the Facebook login.";
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                errorMessage = [error localizedDescription];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error"
                                                            message:errorMessage
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Dismiss", nil];
            [alert show];
        }
        else if (user.isNew)
        {
            NSLog(@"User with facebook signed up and logged in!");
            DVYHomePageViewController *homePage = [[DVYHomePageViewController alloc] initWithNibName:@"DVYHomePageViewController" bundle:nil];
            [self presentViewController:homePage animated:YES completion:nil];
        }
        else
        {
            NSLog(@"User with facebook logged in!");
            DVYHomePageViewController *homePage = [[DVYHomePageViewController alloc] initWithNibName:@"DVYHomePageViewController" bundle:nil];
            [self presentViewController:homePage animated:YES completion:nil];
        }
        
    }];
    
    [_activityIndicator startAnimating]; // Show loading indicator until login is finished

    
}
@end
