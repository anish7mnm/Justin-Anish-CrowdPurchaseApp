//
//  DVYRelationshipToken.h
//  JACrowdPurchasingApp
//
//  Created by Justin on 3/22/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVYUser.h"
#import "DVYCampaign.h"

@interface DVYRelationshipToken : NSObject

@property (nonatomic, strong) DVYUser *user;
@property (nonatomic, strong) DVYCampaign *campaign;
@property (nonatomic) BOOL isCommitted;
@property (nonatomic) BOOL userHasSeenLastVersion;

@property (nonatomic) NSInteger minimumDesiredCommits;
@property (nonatomic, strong) NSNumber *maximumPrice;

- (instancetype)init;
- (instancetype)initWithUser:(DVYUser *)user campaign:(DVYCampaign *)campaign;

@end
