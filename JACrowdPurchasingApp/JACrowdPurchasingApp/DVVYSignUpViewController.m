//
//  DVVYSignUpViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/12/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVVYSignUpViewController.h"
#import <Parse/Parse.h>

@interface DVVYSignUpViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *skipSaveTitleLabel;
- (IBAction)addProfilePictureButton:(id)sender;

- (IBAction)skipSaveAction:(id)sender;
@end

@implementation DVVYSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTextField.delegate = self;
    self.profilePicture.layer.cornerRadius = self.profilePicture.image.size.width / 2;
    self.profilePicture.layer.masksToBounds = YES;
        [self.skipSaveTitleLabel setTitle:@"SKIP" forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.nameTextField) {
    [self.skipSaveTitleLabel setTitle:@"SAVE" forState:UIControlStateNormal];
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

#pragma Adding_Profile_Picture

- (IBAction)addProfilePictureButton:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    self.profilePicture.image = selectedImage;
    [self.skipSaveTitleLabel setTitle:@"SAVE" forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)skipSaveAction:(id)sender {
    if ([self.skipSaveTitleLabel.titleLabel.text isEqualToString:@"SKIP"]) {
        NSLog(@"Segue to HomeScreen");
    }else
    {
        NSLog(@"Segue to HomeScreen with updating User Data");
    }
}
@end
