//
//  DVYTableViewCell.h
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/23/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVYCampaign.h"
#import <QuartzCore/QuartzCore.h>

@interface DVYTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *campaignImagePicture;
@property (weak, nonatomic) IBOutlet UILabel *campaignTitle;
@property (weak, nonatomic) IBOutlet UILabel *hostName;

@property (weak, nonatomic) IBOutlet UIView *innerCell;
@property (weak, nonatomic) IBOutlet UIView *textView;

@property (weak, nonatomic) IBOutlet UIView *progressShell;
@property (weak, nonatomic) IBOutlet UIView *progressFill;

@property (weak, nonatomic) DVYCampaign *cellCampaign;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (nonatomic) NSInteger committedNumberForCell;
@property (nonatomic) NSInteger neededNumberForCell;

@end
