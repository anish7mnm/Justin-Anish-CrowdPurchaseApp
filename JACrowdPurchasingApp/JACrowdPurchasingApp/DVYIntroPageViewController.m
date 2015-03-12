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
    
    PFUser *user = [PFUser user];
    user.username = @"testJustin";
    user.password = @"testjustinpass";
    user.email = @"email@example.com";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"yee");
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"%@", errorString);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (BOOL)isAlreadyUser
{
    return YES;
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
