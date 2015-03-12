//
//  DVYIntroPageViewController.m
//  JACrowdPurchasingApp
//
//  Created by Justin on 3/12/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYIntroPageViewController.h"

@interface DVYIntroPageViewController ()

@end

@implementation DVYIntroPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PFUser *)generateAndUploadParseUserWithEmail:(NSString *)emailAddress password:(NSString *)password
{
    PFUser *newUser = [PFUser user];
    
    newUser.email = emailAddress;
    newUser.password = password;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"yee");
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"%@", errorString);
        }
    }];
    
    
    return newUser;
}

- (BOOL)isValidEmailFormat:(NSString *)emailTextFieldText
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailTextFieldText];
}


- (BOOL)verifyIsAlreadyUserWithEmail:(NSString *)emailAddress
{
    PFQuery *emailQuery = [PFUser query];
    [emailQuery whereKey:@"email" equalTo:emailAddress];
    NSArray *possibleEmailArray = [emailQuery findObjects];
    if ([possibleEmailArray count]>0) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isValidPassword
{
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
