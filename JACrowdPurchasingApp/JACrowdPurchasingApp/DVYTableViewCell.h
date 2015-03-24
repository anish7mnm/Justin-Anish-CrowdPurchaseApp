//
//  DVYTableViewCell.h
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/23/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVYTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *campaignImagePicture;
@property (weak, nonatomic) IBOutlet UILabel *campaignTitle;
@property (weak, nonatomic) IBOutlet UILabel *hostName;

@end
