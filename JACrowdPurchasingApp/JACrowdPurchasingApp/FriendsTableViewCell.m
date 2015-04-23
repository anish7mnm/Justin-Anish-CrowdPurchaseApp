//
//  searchFriendsTableViewCell.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 4/20/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "FriendsTableViewCell.h"

@implementation FriendsTableViewCell

- (void)awakeFromNib {

    self.friendsPic.layer.cornerRadius = self.friendsPic.frame.size.width/2;
    self.friendsPic.layer.masksToBounds = YES;


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
