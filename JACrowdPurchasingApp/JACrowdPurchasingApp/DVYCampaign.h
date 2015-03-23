//
//  DVYCampaign.h
//  JACrowdPurchasingApp
//
//  Created by Justin on 3/22/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVYUser.h"

@interface DVYCampaign : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSDate *deadline;
@property (nonatomic, strong) DVYUser *host;
@property (nonatomic) NSInteger minimumNeededCommits;
@property (nonatomic, strong) NSNumber *price;

@property (nonatomic, strong) NSMutableArray *invitees;
@property (nonatomic, strong) NSMutableArray *watchers;
@property (nonatomic, strong) NSMutableArray *committed;

@property (nonatomic, strong) NSMutableArray *tokens;

@property (nonatomic) BOOL hasMetNeeds;
@property (nonatomic) BOOL hasEnded;

- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail deadline:(NSDate *)deadline host:(DVYUser *)host minimumNeededCommits:(NSInteger)minimumNeededCommits;

- (void)addInvitees:(NSSet *)invitees;
- (void)addInvitee:(DVYUser *)inviteeToAdd;
- (void)removeInvitee:(DVYUser *)inviteeToRemove;

- (void)addWatcher:(DVYUser *)watcherToAdd withMinimum:(NSInteger)minimum;
- (void)removeWatcher:(DVYUser *)watcherToRemove;

- (void)addCommitted:(NSArray *)committed;
- (void)addCommitter:(DVYUser *)committer;
- (void)removeCommitter:(DVYUser *)committer;

- (void)addTokenWithUser:(DVYUser *)user minimumDesiredCommit:(NSInteger)integer;
- (void)removeTokenWithUser:(DVYUser *)user;

- (void)setHasEnded;

- (void)runAutoCommit;

@end

