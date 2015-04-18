//
//  DVYSelfCampaignViewController.h
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/25/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVYCampaignDetailView.h"

@class DVYCampaign;

@interface DVYSelfCampaignViewController : UIViewController <DVYCampaignDetailViewDelegate>

@property (weak, nonatomic) DVYCampaign *campaign;

@end
