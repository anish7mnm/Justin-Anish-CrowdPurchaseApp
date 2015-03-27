//
//  DVYCreateCampaignViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/25/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYCreateCampaignViewController.h"
#import "DVYCampaignDetailView.h"
#import "DVYCampaign.h"

@interface DVYCreateCampaignViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *peopleNeededTextField;
@property (weak, nonatomic) IBOutlet UIButton *createButtonLabelProp;

@property (strong, nonatomic) DVYCampaignDetailView *detailedView;
@end

@implementation DVYCreateCampaignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailedView = [[DVYCampaignDetailView alloc] init];
    [self settingPlaceholdersToTextFields];
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
    
    if (textField == self.titleTextField) {
        self.detailedView.campaignTitle.text =  textField.text;
    }
    if (textField == self.descriptionTextField) {
        self.detailedView.campaignDetails.text =  textField.text;
    }
    if (textField == self.peopleNeededTextField) {
        self.detailedView.peopleNeeded.text =  textField.text;
        self.detailedView.peopleCommited.text = @"1";
    }
    
}


- (void) settingPlaceholdersToTextFields
{
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
}

- (BOOL) checkingIfTheFieldsAreEmptyOrNot
{
    
    if (![self.titleTextField.text isEqualToString:@""] && ![self.descriptionTextField.text isEqualToString:@""] && ![self.peopleNeededTextField.text isEqualToString:@""]) {
        return NO;
    }
    
    return YES;
}

@end
