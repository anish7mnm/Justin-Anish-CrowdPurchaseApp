//
//  DVYTableViewCell.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/23/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYTableViewCell.h"
#import <Parse/Parse.h>
#import "DVYCampaign.h"
#import <Parse/PFRelation.h>
#import "UIColor+dvvyColors.h"

@implementation DVYTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.campaignImagePicture.layer setMasksToBounds:YES];
    [self.campaignImagePicture.layer setCornerRadius:14.0];
    
    [self.innerCell.layer setMasksToBounds:YES];
//    [self.innerCell.layer setCornerRadius:9.0];
    self.innerCell.backgroundColor = [UIColor whiteColor];
//    self.innerCell.layer.shadowOffset = CGSizeMake(-10, 20);
//    self.innerCell.layer.shadowOpacity = 0.5;
//    self.innerCell.layer.shadowRadius = 12;
    
    CGFloat cornerRadiusOfProgressShell = self.campaignImagePicture.frame.size.height*0.15/2;
    [self.progressShell.layer setMasksToBounds:YES];
    [self.progressShell.layer setCornerRadius:cornerRadiusOfProgressShell];
    
    [self.progressFill.layer setMasksToBounds:YES];
    [self.progressFill.layer setCornerRadius:(cornerRadiusOfProgressShell)];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    ;
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    ;
}

- (void)setCellCampaign:(DVYCampaign *)cellCampaign{
    _cellCampaign = cellCampaign;
    
    if (self.cellCampaign.item) {
        Item *campaignItem = self.cellCampaign.item;
        //            [campaignItem fetchIfNeeded];
        
        PFFile *fileImage = campaignItem[@"itemImage"];
        
        [fileImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            UIImage *image = [[UIImage alloc] initWithData:data];
            self.campaignImagePicture.image = image;
        }];
    }
    
    PFQuery *query = [cellCampaign.committed query];
    NSLog(@"CALLED");
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        
        self.committedNumberForCell = (NSInteger)number;
        self.neededNumberForCell = (NSInteger)[cellCampaign.minimumNeededCommits integerValue];
        
        self.numberLabel.text = [NSString stringWithFormat:@"%@/%@", @(self.committedNumberForCell), @(self.neededNumberForCell)];
        
        CGFloat maxFillWidth = (CGFloat)self.progressShell.bounds.size.width;
        
        NSInteger numberOfNeeded = self.neededNumberForCell;
        
        CGFloat fractionCompleted = (CGFloat)self.committedNumberForCell/(CGFloat)self.neededNumberForCell;
        NSLog(@"%f",fractionCompleted);
        
        UIColor *progressFillColor = [UIColor dvvyProgressGreen];
        if (fractionCompleted < 0.33) {
            progressFillColor = [UIColor dvvyProgressOrange];
        } else if (fractionCompleted < 0.66) {
            progressFillColor = [UIColor dvvyProgressYellow];
        } else if (self.committedNumberForCell > self.neededNumberForCell) {
            progressFillColor = [UIColor dvvyProgressBlue];
            fractionCompleted = 1.0;
        }
        self.progressFill.backgroundColor = progressFillColor;
        
        CGFloat progressFillToAddToLeft = maxFillWidth*fractionCompleted;
        NSInteger integerToAdd = ceil(progressFillToAddToLeft);
        
//        NSLog(@"%f", progressFillToAddToLeft);
        
        NSLayoutConstraint *progressFillExtend = [NSLayoutConstraint constraintWithItem:self.progressFill attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.progressFill attribute:NSLayoutAttributeLeft multiplier:1.0 constant:integerToAdd];
        
        [self.progressShell addConstraint:progressFillExtend];
    }];
}

@end
