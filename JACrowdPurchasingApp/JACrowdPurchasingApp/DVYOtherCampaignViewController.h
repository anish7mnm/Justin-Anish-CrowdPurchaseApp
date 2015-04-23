//
//  DVYOtherCampaignViewController.h
//  JACrowdPurchasingApp
//
//  Created by Justin on 3/30/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVYUser.h"
#import "DVYCampaign.h"

@interface DVYOtherCampaignViewController : UIViewController

@property (strong, nonatomic) DVYCampaign *campaign;
@property (strong, nonatomic) DVYUser *currentUser;

@end
