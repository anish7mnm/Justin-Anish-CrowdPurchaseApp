//
//  DVYDataStore.h
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/23/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVYDataStore : NSObject

@property (strong, nonatomic) NSMutableArray *selfCampaigns;
@property (strong, nonatomic) NSMutableArray *othersCampaign;
@property (strong, nonatomic) NSMutableArray *alertCampaign;

@property (strong, nonatomic) NSMutableArray *users;



+ (instancetype)sharedLocationsDataStore;

@end