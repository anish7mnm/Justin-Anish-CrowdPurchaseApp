//
//  DVVYSignUpViewController.h
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/12/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DVVYSignUpViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic, readwrite) PFUser *user;

@end
