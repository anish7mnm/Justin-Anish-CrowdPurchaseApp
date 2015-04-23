//
//  VenmoPaymentViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 4/23/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//


#import <Venmo-iOS-SDK/Venmo.h>
#import "VenmoPaymentViewController.h"

#import "DVYUser.h"

@interface VenmoPaymentViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *collectLabel;

@property (weak, nonatomic) IBOutlet UIButton *sendRequest;

@property (weak, nonatomic) IBOutlet UITextField *enterAmount;

@property (nonatomic) VENUser *venmoUser;

@end

@implementation VenmoPaymentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.enterAmount.delegate = self;
    
    if (![Venmo isVenmoAppInstalled])
    {
        [[Venmo sharedInstance] setDefaultTransactionMethod:VENTransactionMethodAPI];
    }
    else
    {
        [[Venmo sharedInstance] setDefaultTransactionMethod:VENTransactionMethodAppSwitch];
    }
    
    self.venmoUser = [[Venmo sharedInstance] session].user;
    
    self.sendRequest.enabled = NO;
    
    self.collectLabel.text = [NSString stringWithFormat:@"Your Campaign cost will be divided eqully by %ld", self.numberOfPeople];
    
    
}


- (IBAction)sendRequestButtonTapped:(id)sender
{
    CGFloat cost = ([self.enterAmount.text floatValue]/self.numberOfPeople)*100; //([self.price intValue] / self.numberOfPeople);
    
    NSString *dvvyNote = [NSString stringWithFormat:@"DVVY: %@", self.campaignTitle];
    
    //[NSString stringWithFormat:@"%@ %@", self.venmoUser.firstName, self.venmoUser.lastName];
    
    NSString *email = self.venmoUser.primaryEmail;
    
    for (DVYUser *user in self.listOfFriends)
    {
        
        NSString *emailAddress = user.email;
        
        if (![emailAddress isEqualToString:email])
        {
            
            [[Venmo sharedInstance] sendRequestTo:emailAddress amount:cost note:dvvyNote completionHandler:^(VENTransaction *transaction, BOOL success, NSError *error)
            {
                if (success)
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Done!"
                                                                        message:[NSString stringWithFormat:@"Request sent successfully to %@", emailAddress]
                                                                       delegate:self
                                                              cancelButtonTitle:nil
                                                              otherButtonTitles:@"COOL", nil];
                    [alertView show];
                    
                }else
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR!"
                                                                        message:[NSString stringWithFormat:@"Request not sent to %@", emailAddress]
                                                                       delegate:self
                                                              cancelButtonTitle:nil
                                                              otherButtonTitles:@"OK", nil];
                    [alertView show];
                    
                }
            }];
        }
        
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if ([textField.text floatValue] > 0) {
        
        return YES;
    }
    else
    {
        return NO;
    }
    
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.sendRequest.enabled = YES;
}


- (IBAction)doneButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
