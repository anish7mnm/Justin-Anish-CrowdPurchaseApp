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
#import "UIImage+animatedGIF.h"

@implementation DVYTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.campaignImagePicture.layer setMasksToBounds:YES];
    [self.campaignImagePicture.layer setCornerRadius:14.0];
    
    [self.innerCell.layer setMasksToBounds:YES];
//    [self.innerCell.layer setCornerRadius:18.0];
    self.innerCell.backgroundColor = [UIColor whiteColor];
//    self.innerCell.layer.shadowOffset = CGSizeMake(-10, 20);
//    self.innerCell.layer.shadowOpacity = 0.5;
//    self.innerCell.layer.shadowRadius = 12;
    
    CGFloat cornerRadiusOfProgressShell = self.textView.frame.size.height*0.25/2;
    [self.progressShell.layer setMasksToBounds:YES];
    [self.progressShell.layer setCornerRadius:cornerRadiusOfProgressShell];
    
    [self.progressFill.layer setMasksToBounds:YES];
//    [self.progressFill.layer setCornerRadius:(cornerRadiusOfProgressShell)];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    
    
    if (selected) {
        [UIView animateWithDuration:0.4
                              delay:0
             usingSpringWithDamping:4.0
              initialSpringVelocity:0
                            options:0
                         animations:^{
                             self.campaignTitle.textColor = [UIColor whiteColor];
                             self.hostName.textColor = [UIColor whiteColor];
                             self.detailTextLabel.textColor = [UIColor whiteColor];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:10.0
                                  delay:0
                 usingSpringWithDamping:4.0
                  initialSpringVelocity:0
                                options:0
                             animations:^{
                                 self.campaignTitle.textColor = [UIColor dvvyDarkGrey];
                                 self.hostName.textColor = [UIColor lightGrayColor];
                                 self.detailTextLabel.textColor = [UIColor lightGrayColor];
            } completion:^(BOOL finished) {
                self.campaignTitle.textColor = [UIColor dvvyDarkGrey];
                self.hostName.textColor = [UIColor lightGrayColor];
                self.detailTextLabel.textColor = [UIColor lightGrayColor];
            }];
        }];
    }
    
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
    } else {
        NSURL *pusheenDance = [NSURL URLWithString:@"http://33.media.tumblr.com/tumblr_m9hbpdSJIX1qhy6c9o1_400.gif"];
        self.campaignImagePicture.image = [UIImage animatedImageWithAnimatedGIFURL:pusheenDance];
        self.campaignImagePicture.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    
    PFQuery *query = [cellCampaign.committed query];
    NSLog(@"CALLED");
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        
        self.campaignTitle.text = self.cellCampaign.title;
        
        DVYUser *host = self.cellCampaign.host;
        self.hostName.text = [NSString stringWithFormat:@"Made by: %@", [host objectForKey:@"fullName"]];
        
        self.committedNumberForCell = (NSInteger)number;
        self.neededNumberForCell = (NSInteger)[cellCampaign.minimumNeededCommits integerValue];
        
        if (self.committedNumberForCell>=self.neededNumberForCell) {
            self.numberLabel.text = [NSString stringWithFormat:@"Complete! (%@/%@) ", @(self.committedNumberForCell), @(self.neededNumberForCell)];
        } else {
            self.numberLabel.text = [NSString stringWithFormat:@"%@/%@ Needed", @(self.committedNumberForCell), @(self.neededNumberForCell)];
        }
        
        CGFloat maxFillWidth = (CGFloat)self.progressShell.bounds.size.width;
                
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
//        self.progressFill.transform = CGAffineTransformScale(self.progressShell.transform, 0.001, 1);
        
        
        NSLayoutConstraint *progressFillExtend = [NSLayoutConstraint constraintWithItem:self.progressFill attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.progressFill attribute:NSLayoutAttributeLeft multiplier:1.0 constant:integerToAdd];
        
        [self layoutIfNeeded];
        [self.progressShell addConstraint:progressFillExtend];
        
        CGFloat randomDelay = arc4random_uniform(10)/100.00;
        
        [UIView animateWithDuration:0.7
                              delay:randomDelay
             usingSpringWithDamping:1.0
              initialSpringVelocity:1.0
                            options:0
                         animations:^{
                             [self layoutIfNeeded];
//                             self.progressFill.transform = CGAffineTransformScale(self.progressShell.transform, fractionCompleted, 1);
                         } completion:^(BOOL finished) {
//                             [self.progressShell addConstraint:progressFillExtend];
                         }];
        
    }];
}

@end
