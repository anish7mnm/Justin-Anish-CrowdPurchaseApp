//
//  DVYCampaign.h
//  JACrowdPurchasingApp
//
//  Created by Justin on 3/22/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.


#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

//Importing other models
#import "DVYUser.h"
#import "Item.h"


@interface DVYCampaign : PFObject <PFSubclassing>


@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *detail;

@property (nonatomic, strong) NSDate *deadline;

@property (nonatomic, strong) DVYUser *host;

@property (nonatomic, strong) NSNumber *minimumNeededCommits;

@property (nonatomic, strong) NSNumber *committedCount;

@property (nonatomic, strong) PFRelation *invitees;

@property (nonatomic, strong) PFRelation *committed;

@property (nonatomic) BOOL hasMetNeeds;

@property (nonatomic) BOOL hasEnded;

@property (nonatomic, strong) Item *item;


//@property (nonatomic, strong) UIImage *itemImage;

/*
@property (nonatomic, strong) NSMutableArray *tokens;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSMutableArray *watchers;
*/


//- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail deadline:(NSDate *)deadline host:(DVYUser *)host minimumNeededCommits:(NSNumber *)minimumNeededCommits;

- (void)checkIfCampiagnHasMetNeeds;


- (void)addInvitees:(NSArray *)invitees;
- (void)addInvitee:(DVYUser *)inviteeToAdd;
- (void)removeInvitee:(DVYUser *)inviteeToRemove;

//- (void)addWatcher:(DVYUser *)watcherToAd d withMinimum:(NSInteger)minimum;
//- (void)removeWatcher:(DVYUser *)watcherToRemove;

- (void)addCommitted:(NSArray *)committed;
- (void)addCommitter:(DVYUser *)committer;
- (void)removeCommitter:(DVYUser *)committer;

//- (void)addTokenWithUser:(DVYUser *)user minimumDesiredCommit:(NSInteger)integer;
//- (void)removeTokenWithUser:(DVYUser *)user;

//- (void)setHasEnded;

//- (void)runAutoCommit;

@end

