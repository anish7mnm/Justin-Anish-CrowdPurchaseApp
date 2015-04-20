//
//  FriendCollectionViewCell.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 4/18/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "FriendCollectionViewCell.h"

@implementation FriendCollectionViewCell

- (void)awakeFromNib {
    
    self.friendProfilePicture.layer.cornerRadius = self.friendProfilePicture.frame.size.width/2;
    self.friendProfilePicture.layer.masksToBounds = YES;
    
}

@end
