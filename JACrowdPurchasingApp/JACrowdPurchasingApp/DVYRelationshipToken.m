//
//  DVYRelationshipToken.m
//  JACrowdPurchasingApp
//
//  Created by Justin on 3/22/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYRelationshipToken.h"
#import "DVYUser.h"
#import "DVYCampaign.h"

@implementation DVYRelationshipToken

- (BOOL)userHasSeenLastVersion
{
    // Edit this for notifications
    return YES;
}

// Inits

- (instancetype)init
{
    self = [super init];
    if (self) {
        _user = nil;
        _campaign = nil;
        _isCommitted = NO;
        _minimumDesiredCommits = 1;
        _maximumPrice = @(999999999);
    }
    return self;
}

- (instancetype)initWithUser:(DVYUser *)user campaign:(DVYCampaign *)campaign
{
    DVYRelationshipToken *newToken = [[DVYRelationshipToken alloc] init];
    if (newToken) {
        newToken.user = user;
        newToken.campaign = campaign;
    }
    return newToken;
}

- (void)setMinimumDesiredCommitsAccordingToMaximumPrice
{
    if (![self.maximumPrice isEqual:@(999999999)]) {
        float priceToDivide = [self.campaign.price floatValue];
        float priceToDivideBy = [self.maximumPrice floatValue];
        NSInteger numberCommitsNeeded = ceil(priceToDivide/priceToDivideBy);
        _minimumDesiredCommits = numberCommitsNeeded;
    }
    else
    {
        NSLog(@"Cannot set minimum via maximumPrice. No maximumPrice set");
    }
}


@end
