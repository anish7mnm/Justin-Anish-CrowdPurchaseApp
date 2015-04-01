//
//  DVYCreateCampaignViewController.h
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/25/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DVYCampaign;
@interface DVYCreateCampaignViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSString *buttonName;
@property (strong, nonatomic) NSString *titlePlaceholder;
@property (strong, nonatomic) NSString *descriptionPlaceholder;
@property (strong, nonatomic) NSString *numberOfPeoplePlaceHolder;

@property (nonatomic) DVYCampaign *campaignToUpdate;

@property (weak, nonatomic) IBOutlet UIButton *createButtonLabelProp;


@end
