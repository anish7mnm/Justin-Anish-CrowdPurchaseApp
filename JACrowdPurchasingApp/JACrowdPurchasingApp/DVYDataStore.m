//
//  DVYDataStore.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/23/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYDataStore.h"

@implementation DVYDataStore

+ (instancetype)sharedLocationsDataStore {
    static DVYDataStore *_sharedCampaignsDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedCampaignsDataStore = [[DVYDataStore alloc] init];
    });
    
    return _sharedCampaignsDataStore;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _selfCampaigns = [[NSMutableArray alloc] init];
        _othersCampaign = [[NSMutableArray alloc] init];
        _alertCampaign = [[NSMutableArray alloc] init];
        _users = [[NSMutableArray alloc] init];
    }
    return self;
}




@end
