//
//  DVYCreateCampaignViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/25/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYCreateCampaignViewController.h"
#import "DVYSelfCampaignViewController.h"
#import "DVYCampaignDetailView.h"
#import "DVYCampaign.h"

@interface DVYCreateCampaignViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *peopleNeededTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *deadlinePicker;

@property (strong, nonatomic) DVYCampaignDetailView *detailedView;

@end

@implementation DVYCreateCampaignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.buttonName) {
        [self.createButtonLabelProp setTitle:self.buttonName forState:UIControlStateNormal];
    }
    self.titleTextField.delegate = self;
    self.descriptionTextField.delegate = self;
    self.peopleNeededTextField.delegate = self;
    
    
    self.createButtonLabelProp.enabled = NO;
    
    [self settingPlaceholdersToTextFields];
    
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"DVYCampaignDetailView" owner:self options:nil];
    self.detailedView = [nibViews firstObject];
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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


- (void) settingPlaceholdersToTextFields
{
    if ([self.createButtonLabelProp.titleLabel.text isEqualToString:@"Update"]) {
        self.titleTextField.text = self.titlePlaceholder;
        self.descriptionTextField.text = self.descriptionPlaceholder;
        self.peopleNeededTextField.text = self.numberOfPeoplePlaceHolder;
        
    }
    else{
        if ([self.titleTextField.text isEqualToString:@""]) {
            self.titleTextField.placeholder = @"Enter the title of your Campaign";
        } else {
            self.titleTextField.placeholder = self.detailedView.campaignTitle.text;
        }
        
        if ([self.descriptionTextField.text isEqualToString:@""]) {
            self.descriptionTextField.placeholder = @"Enter all the relevent details (Link, Price etc.)";
        } else {
            self.descriptionTextField.placeholder = self.detailedView.campaignDetails.text;
        }
        
        if ([self.peopleNeededTextField.text isEqualToString:@""]) {
            self.peopleNeededTextField.placeholder = @"Min. #";
        } else {
            self.peopleNeededTextField.placeholder = self.detailedView.peopleNeeded.text;
            self.campaignToUpdate.minimumNeededCommits = @([self.detailedView.peopleNeeded.text integerValue]);
        }
        
        [self.campaignToUpdate saveInBackground];
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)uploadImageButtonTapped:(id)sender {
    
    self.createButtonLabelProp.enabled = YES;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    self.detailedView.profilePicture.image = selectedImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
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

- (BOOL) checkingIfTheFieldsAreEmptyOrNot
{
    
    if (self.titleTextField && self.descriptionTextField && self.peopleNeededTextField) {
        return NO;
    }
    
    return YES;
}


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
    
    DVYUser *host = [PFUser currentUser];
    campaign.host = host;
    
    PFRelation *relation = [campaign relationForKey:@"committed"];
    [relation addObject:host];
    
    [campaign saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
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
