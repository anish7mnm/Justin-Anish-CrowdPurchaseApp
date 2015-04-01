//
//  DVYDataStore.h
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/23/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVYDataStore : NSObject

@property (strong, nonatomic) NSArray *selfCampaigns;
@property (strong, nonatomic) NSMutableArray *othersCampaign;
@property (strong, nonatomic) NSMutableArray *alertCampaign;
@property (strong, nonatomic) NSArray *friends;
@property (strong, nonatomic) NSMutableArray *users;

+ (instancetype)sharedLocationsDataStore;

-(void) getselfCampaignsWithCompletionBlock: (void (^)(void))completionBlock;
- (void) getFacebookFriendsWithCompletionBlock: (void (^)(void)) completionBlock;

@end
