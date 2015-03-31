//
//  Item.h
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/27/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Item : PFObject <PFSubclassing>

@property (strong, nonatomic) UIImage *itemImage;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *description;
@end
