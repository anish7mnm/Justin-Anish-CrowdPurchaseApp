//
//  DVYCreateCampaignViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/25/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYCreateCampaignViewController.h"
#import "DVYCampaignDetailView.h"

@interface DVYCreateCampaignViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *peopleNeededTextField;
@property (weak, nonatomic) IBOutlet UIButton *createButtonLabelProp;

@property (weak, nonatomic) IBOutlet DVYCampaignDetailView *detailCampaignViewForSelf;

@end

@implementation DVYCreateCampaignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
