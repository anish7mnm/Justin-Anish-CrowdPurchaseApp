//
//  DVYIntroPageViewController.m
//  JACrowdPurchasingApp
//
//  Created by Justin on 3/12/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYIntroPageViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DVVYSignUpViewController.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <FacebookSDK/FacebookSDK.h>

@interface DVYIntroPageViewController ()

@property (strong, nonatomic) PFUser *user;

@property (weak, nonatomic) IBOutlet UITextField *emailAddressField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

- (IBAction)buttonPressed:(id)sender;
- (IBAction)fbLoginTapped:(id)sender;

@end

@implementation DVYIntroPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Parse setApplicationId:@"parseAppId" clientKey:@"parseClientKey"];
    
    
    self.emailAddressField.delegate = self;
    self.passwordField.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // if finished editing email field
    if (textField == self.emailAddressField) {
        
        // if email format is valid
        if ([self verifyIsValidEmailFormat:textField.text]) {
            // Indicate valid format
            
            [self setTextFieldColorToGreen:textField];
            
            // if email exists in database
            if ([self verifyIsAlreadyUserWithEmail:textField.text]) {
                
                // is already user. change button to login
                [self setButtonToLogin];
                    
                
                
            } else {
                
                // is not user. change button to sign up
                [self setButtonToSignUp];
            }
        }
        
        // if email format is invalid
        else {
            // Sorry. Invalid email format...
            // Indicate invalid format
            [self setTextFieldColorToRed:textField];
            [self setButtonToHidden];
            
        }
    }
    
    // if finished editing password field
    else if (textField == self.passwordField) {
        
        // if password format is valid
        if ([self verifyIsValidPassword:textField.text]) {
            // Indicate valid password format
            [self setTextFieldColorToGreen:textField];
        }
        
        // if password format is invalid
        else {
            [self setTextFieldColorToRed:textField];
            [self setButtonToHidden];
        }
    }
}

- (void)setButtonToSignUp
{
    self.submitButton.hidden = NO;
    [self.submitButton setTitle:@"Sign up" forState:UIControlStateNormal];
}

- (void)setButtonToLogin
{
    self.submitButton.hidden = NO;
    [self.submitButton setTitle:@"Log in" forState:UIControlStateNormal];
}

- (void)setButtonToHidden
{
    self.submitButton.hidden = YES;
}

- (void)setTextFieldColorToRed:(UITextField *)textField
{
    textField.layer.borderColor=[[UIColor redColor] CGColor];
    textField.layer.borderWidth= 1.0f;
}

- (void)setTextFieldColorToGreen:(UITextField *)textField
{
    textField.layer.borderColor=[[UIColor greenColor] CGColor];
    textField.layer.borderWidth= 1.0f;
}

- (void)setTextFieldBorderToClear:(UITextField *)textField
{
    textField.layer.borderColor=[[UIColor clearColor]CGColor];
}

- (PFUser *)generateAndUploadParseUserWithEmail:(NSString *)emailAddress password:(NSString *)password
{
    PFUser *newUser = [PFUser user];
    
    newUser.username = emailAddress;
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

- (BOOL)verifyIsValidEmailFormat:(NSString *)emailTextFieldText
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

//- (BOOL) verifyIsCorrectLoginInfo:(NSString *)emailAddress password:(NSString *)password
//{
//    PFQuery *emailQuery = [PFUser query];
//    [emailQuery whereKey:@"email" equalTo:emailAddress];
//    NSArray *possibleEmailArray = [emailQuery findObjects];
//    if ([possibleEmailArray count]>0) {
//        PFQuery
//    }
//    
//    return NO;
//}

//- (BOOL)verifyIsCorrectLoginInfoWithEmail:(NSString *)emailAddress: (NSString *)password
//{
//    [PFUser logInWithUsernameInBackground:emailAddress password:password
//                                    block:^(PFUser *user, NSError *error) {
//                                        if (user) {
//                                            // Segue
//                                        } else {
//                                            // The login failed. Check error to see why.
//                                        }
//                                    }];
//}


- (BOOL)verifyIsValidPassword:(NSString *)password;
{
    if (password.length>0) {
        return YES;
    }
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonPressed:(id)sender {
    if ([self.submitButton.titleLabel.text isEqualToString:@"Sign up"]) {
        
        PFUser *newUser = [PFUser user];
        newUser.username = self.emailAddressField.text;
        newUser.password = self.passwordField.text;
        
        DVVYSignUpViewController *signUpViewController = [[DVVYSignUpViewController alloc] initWithNibName:@"DVVYSignUpViewController" bundle:nil];
        
        signUpViewController.user = newUser;
        
        [self presentViewController:signUpViewController animated:YES completion:nil];
    }
}

- (IBAction)fbLoginTapped:(id)sender {
    [PFFacebookUtils logInWithPermissions:permissions block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
        } else {
            NSLog(@"User logged in through Facebook!");
        }
    }];
}
@end
