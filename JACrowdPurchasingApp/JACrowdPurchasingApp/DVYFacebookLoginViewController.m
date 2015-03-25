//
//  DVYFacebookLoginViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/23/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYFacebookLoginViewController.h"
#import "DVYHomePageViewController.h"
#import "DVYParseAPIClient.h"

#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface DVYFacebookLoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *buttonLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *elementViews;

- (IBAction)facebookTapped:(id)sender;

@end

@implementation DVYFacebookLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityIndicator.hidden = YES;
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = self.backgroundImage.frame;
    [self.backgroundImage addSubview:visualEffectView];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Check if user is cached and linked to Facebook, if so, bypass login
    if ([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        [self presentHomePageViewController];
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
    
    [DVYParseAPIClient logInWithFacebookWithCompletionBlock:^{
        
        [_activityIndicator stopAnimating];
        [self presentHomePageViewController];
        
    } AndSignUpComletionBlock:^{

        [self facebookdetails];
        [_activityIndicator stopAnimating];
        [self presentHomePageViewController];

    }];
    // Login PFUser using Facebook
        self.activityIndicator.hidden=NO;
    [_activityIndicator startAnimating]; // Show loading indicator until login is finished
}

-(void) facebookdetails
{
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        // handle response
        if (!error) {
            // Parse the data received
            NSDictionary *userData = (NSDictionary *)result;
            NSLog(@"SSE: %@", userData);
            [[PFUser currentUser] setObject:userData[@"name"] forKey:@"fullName"];
            [[PFUser currentUser] setObject:userData[@"email"] forKey:@"email"];
            
            NSString *facebookID = userData[@"id"];
            NSString *profilePicture = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID];
            
            [[PFUser currentUser] setObject:profilePicture forKey:@"profilePicture"];
            
            [[PFUser currentUser] saveInBackground];
            
        } else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
                    isEqualToString: @"OAuthException"]) { // Since the request failed, we can check if it was due to an invalid session
            NSLog(@"The facebook session was invalidated");
        } else {
            NSLog(@"Some other error: %@", error);
        }
    }];

}

-(void) presentHomePageViewController
{
    UIStoryboard *myStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   
    UIViewController *homePage = [myStoryboard instantiateInitialViewController];
    [self presentViewController:homePage animated:YES completion:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
