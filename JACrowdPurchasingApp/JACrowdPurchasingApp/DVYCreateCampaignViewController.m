//
//  DVYCreateCampaignViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/25/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//


#import "DVYHomePageViewController.h"
#import "DVYCreateCampaignViewController.h"
#import "DVYSelfCampaignViewController.h"
#import "DVYCampaignDetailView.h"
#import "DVYCampaign.h"



@interface DVYCreateCampaignViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *peopleNeededTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *deadlinePicker;
@property (weak, nonatomic) IBOutlet UIView *bgWindow;

@property (strong, nonatomic) DVYCampaignDetailView *detailedView;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIButton *uploadImageButton;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end




@implementation DVYCreateCampaignViewController


#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.buttonName) {
        [self.createButtonLabelProp setTitle:self.buttonName forState:UIControlStateNormal];
    }
    self.titleTextField.delegate = self;
    self.descriptionTextField.delegate = self;
    self.peopleNeededTextField.delegate = self;
    
//    self.bgWindow.layer.cornerRadius = 10.0;
    
    self.createButtonLabelProp.enabled = NO;
    
    [self settingPlaceholdersToTextFields];
    
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"DVYCampaignDetailView" owner:self options:nil];
    self.detailedView = [nibViews firstObject];
    
    // Do any additional setup after loading the view.
    self.contentView.layer.cornerRadius = 4.0f;
    self.uploadImageButton.layer.cornerRadius = 4.0f;
    self.createButton.layer.cornerRadius = 4.0f;
    self.cancelButton.layer.cornerRadius = 4.0f;
    
//    self.view.backgroundColor = [UIColor clearColor];
//    self.view.opaque = NO;
    
}



#pragma mark - UITextField Delegate Methods

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    BOOL check = [self checkingIfTheFieldsAreEmptyOrNot];
    if (check == NO) {
        self.createButtonLabelProp.enabled = YES;
    }
    
    if ([self.createButtonLabelProp.titleLabel.text isEqualToString:@"Create"]) {
        
        if (textField == self.titleTextField) {
            self.detailedView.campaignTitle.text =  textField.text;
        }
        if (textField == self.descriptionTextField) {
            self.detailedView.campaignDetails.text =  textField.text;
        }
        if (textField == self.peopleNeededTextField) {
            self.detailedView.peopleNeeded.text =  textField.text;
            //self.detailedView.peopleCommited.text = @"1";
        }
        
    }
    
    
    if ([self.createButtonLabelProp.titleLabel.text isEqualToString:@"Update"]) {
        
        if (textField == self.titleTextField) {
            self.detailedView.campaignTitle.text =  textField.text;
            self.campaignToUpdate.title = self.detailedView.campaignTitle.text;

        }
        if (textField == self.descriptionTextField) {
            self.detailedView.campaignDetails.text =  textField.text;
            self.campaignToUpdate.detail = self.detailedView.campaignDetails.text;

        }
        if (textField == self.peopleNeededTextField) {
            self.detailedView.peopleNeeded.text =  textField.text;
            //self.detailedView.peopleCommited.text = @"1";
        }

    }
    
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.createButtonLabelProp.titleLabel.text isEqualToString:@"Update"]) {
        self.createButtonLabelProp.enabled = YES;
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}


// It is important for you to hide the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}




#pragma mark - UIButton Actions


- (IBAction)uploadImageButtonTapped:(id)sender {
    
    self.createButtonLabelProp.enabled = YES;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
    
}


- (IBAction)createThePageButtonTapped:(id)sender {
    
    if ([self.createButtonLabelProp.titleLabel.text isEqualToString:@"Create"]) {
        NSLog(@"Created");
        [self createCampaign];
        }
    
    else{
        NSLog(@"Updated");
        [self updateCampaign];
    }
    
}


- (IBAction)cancelButtonTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - UITextViewDelegate Helper Methods

- (BOOL) checkingIfTheFieldsAreEmptyOrNot
{
    
    if (self.titleTextField && self.descriptionTextField && self.peopleNeededTextField) {
        return NO;
    }
    
    return YES;
}


- (void) settingPlaceholdersToTextFields
{
    if ([self.createButtonLabelProp.titleLabel.text isEqualToString:@"Update"]) {
        self.titleTextField.text = self.titlePlaceholder;
        self.descriptionTextField.text = self.descriptionPlaceholder;
        self.peopleNeededTextField.text = self.numberOfPeoplePlaceHolder;
        
    }
    else{
        if ([self.titleTextField.text isEqualToString:@""]) {
            self.titleTextField.placeholder = @"Campaign Title";
        } else {
            self.titleTextField.placeholder = self.detailedView.campaignTitle.text;
        }
        
        if ([self.descriptionTextField.text isEqualToString:@""]) {
            self.descriptionTextField.placeholder = @"Campaign Details";
        } else {
            self.descriptionTextField.placeholder = self.detailedView.campaignDetails.text;
        }
        
        if ([self.peopleNeededTextField.text isEqualToString:@""]) {
            self.peopleNeededTextField.placeholder = @"0";
        } else {
            self.peopleNeededTextField.placeholder = self.detailedView.peopleNeeded.text;
            self.campaignToUpdate.minimumNeededCommits = @([self.detailedView.peopleNeeded.text integerValue]);
        }
        
        [self.campaignToUpdate saveInBackground];
    }
}



#pragma mark - UIPickerView Delegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    self.detailedView.profilePicture.image = selectedImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - UIButton Helper Methods

- (void) createCampaign
{
    DVYCampaign *campaign = [[DVYCampaign alloc]init];
    
    campaign.title = self.titleTextField.text;
    campaign.detail = self.descriptionTextField.text;
    campaign.minimumNeededCommits = @([self.peopleNeededTextField.text integerValue]);
    
    campaign.deadline = self.deadlinePicker.date;
    
    if (self.detailedView.profilePicture.image) {
        Item *campaignItem = [[Item alloc] init];
        
        NSData* data = UIImageJPEGRepresentation(self.detailedView.profilePicture.image, 0.5f);
        
        PFFile *imageFile = [PFFile fileWithData:data];
        campaignItem[@"itemImage"] = imageFile;
        campaign.item = campaignItem;
        
    }
    
    DVYUser *host = (DVYUser *)[PFUser currentUser];
    campaign.host = host;
    
    PFRelation *relation = [campaign relationForKey:@"committed"];
    [relation addObject:host];
    
    [campaign saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        DVYHomePageViewController *homeVC = (DVYHomePageViewController *)self.presentingViewController.childViewControllers[0];
        [homeVC refresh];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}


- (void) updateCampaign
{
    self.campaignToUpdate.title = self.titleTextField.text;
    self.campaignToUpdate.detail = self.descriptionTextField.text;
    self.campaignToUpdate.minimumNeededCommits = @([self.peopleNeededTextField.text integerValue]);
    
    if (self.detailedView.profilePicture.image) {
        
        [self.campaignToUpdate removeObjectForKey:@"item"];
        Item *campaignItem = [[Item alloc] init];
        
        NSData* data = UIImageJPEGRepresentation(self.detailedView.profilePicture.image, 0.5f);
        
        PFFile *imageFile = [PFFile fileWithData:data];
        campaignItem[@"itemImage"] = imageFile;
        self.campaignToUpdate.item = campaignItem;
        
    }
    
    [self.campaignToUpdate saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self dismissViewControllerAnimated:YES completion:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done"
                                                        message:@"Campaign Updated!"
                                                       delegate:self
                                              cancelButtonTitle:@"Cool"
                                              otherButtonTitles:nil];
        [alert show];
    }];

}


@end
