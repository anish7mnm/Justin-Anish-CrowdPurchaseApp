//
//  DVYUser.h
//  JACrowdPurchasingApp
//
//  Created by Justin on 3/22/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVYUser : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;

@property (nonatomic, strong) NSMutableArray *campaignsCurrentlyHosting;
@property (nonatomic, strong) NSMutableArray *campaignsHosted;

@end
