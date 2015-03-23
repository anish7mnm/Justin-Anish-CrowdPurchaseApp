//
//  DVYCampaign.m
//  JACrowdPurchasingApp
//
//  Created by Justin on 3/22/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYCampaign.h"
#import "DVYUser.h"
#import "DVYRelationshipToken.h"

@implementation DVYCampaign

- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail deadline:(NSDate *)deadline host:(DVYUser *)host minimumNeededCommits:(NSInteger)minimumNeededCommits
{
    self = [[DVYCampaign alloc] init];
    if (self) {
        _title = title;
        _detail = detail;
        _deadline = deadline;
        _host = host;
        _minimumNeededCommits = minimumNeededCommits;
        _price = @(0);
        
        _invitees = [[NSMutableArray alloc] init];
        _committed = [[NSMutableArray alloc] init];
        
        _tokens = [[NSMutableArray alloc] init];
        [_tokens addObject:[self generateHostToken]];
        
        _hasEnded = NO;
    }
    
    return self;
}

- (DVYRelationshipToken *)generateHostToken
{
    DVYRelationshipToken *hostToken = [[DVYRelationshipToken alloc] initWithUser:self.host campaign:self];
    hostToken.minimumDesiredCommits = self.minimumNeededCommits;
    
    return hostToken;
}

- (void)addInvitees:(NSArray *)invitees
{
    for (DVYUser *invitee in invitees) {
        [_invitees addObject:invitee];
    }
}

- (void)addInvitee:(DVYUser *)inviteeToAdd
{
    [_invitees addObject:inviteeToAdd];
}

- (void)removeInvitee:(DVYUser *)inviteeToRemove
{
    [_invitees removeObject:inviteeToRemove];
}

//- (void)addWatcher:(DVYUser *)watcherToAdd withMinimum:(NSInteger)minimum
//{
//    [_watchers addObject:watcherToAdd];
//    // [self removeInvitee:watcherToAdd];
//}
//
//- (void)removeWatcher:(DVYUser *)watcherToRemove {
//    [_watchers removeObject:watcherToRemove];
//}

- (void)addCommitted:(NSArray *)committed
{
    for (DVYUser *committer in committed) {
        [_committed addObject:committer];
    }
}

- (void)addCommitter:(DVYUser *)committer
{
    [_committed addObject:committer];
}

- (void)removeCommitter:(DVYUser *)committer
{
    [_committed removeObject:committer];
}

- (BOOL)hasMetNeeds
{
    if ([self.committed count] >= self.minimumNeededCommits) {
        return YES;
    }
    else {
        return NO;
    }
}

- (void)setHasEnded
{
    _hasEnded = YES;
}

- (void)addTokenWithUser:(DVYUser *)user minimumDesiredCommit:(NSInteger)integer
{
    DVYRelationshipToken *token = [[DVYRelationshipToken alloc] initWithUser:user campaign:self];
    token.minimumDesiredCommits = integer;
    [_tokens addObject:token];
}

- (void)removeTokenWithUser:(DVYUser *)user
{
    for (DVYRelationshipToken *token in self.tokens) {
        if (token.user == user) {
            [self.tokens removeObject:token];
        }
    }
}

- (void)runAutoCommit
{
    [self sortTokens];
    NSMutableArray *tokensToConsider = [self.tokens copy];
    
    for (DVYRelationshipToken *token in self.tokens) {
        
        NSInteger highestMinimumCommitToConsider = [self highestMinimumCommitInArray:tokensToConsider];
        NSMutableArray *arrayOfCompatibleTokens = [self arrayOfTokensWithMinimumAtOrLessThan:highestMinimumCommitToConsider inArray:tokensToConsider];
        
        if ([arrayOfCompatibleTokens count]>highestMinimumCommitToConsider) {
            for (DVYRelationshipToken *token in arrayOfCompatibleTokens) {
                token.isCommitted = YES;
                self.committed = arrayOfCompatibleTokens;
            }
            continue;
        }
        else {
            [tokensToConsider removeObjectAtIndex:0];
        }
    }
    
}

- (NSMutableArray *)arrayOfTokensWithMinimumAtOrLessThan:(NSInteger)minimum inArray:(NSArray *)array
{
    NSMutableArray *arrayToReturn = [[NSMutableArray alloc] init];
    
    for (DVYRelationshipToken *token in array) {
        if (token.minimumDesiredCommits <= minimum) {
            [arrayToReturn addObject:token];
        }
    }
    
    return arrayToReturn;
}

- (NSInteger)highestMinimumCommitInArray:(NSArray *)array
{
    NSInteger highest = 0;
    
    for (DVYRelationshipToken *token in array) {
        if (token.minimumDesiredCommits > highest) {
            highest = token.minimumDesiredCommits;
        }
    }
    
    return highest;
}

- (void)sortTokens
{
    NSSortDescriptor *sortByDescendingMinimumCommits = [NSSortDescriptor sortDescriptorWithKey:@"minimumDesiredCommits" ascending:NO];
    self.tokens = [[self.tokens sortedArrayUsingDescriptors:@[sortByDescendingMinimumCommits]] mutableCopy];
}


//- (NSMutableArray *)generateOrderedArrayOfRelationshipTokensFromWatchers:(NSMutableArray *)watchers;
//{
//    NSMutableArray *arrayToSort = [[NSMutableArray alloc] init];
//    
//    for (DVYUser *user in watchers) {
//        DVYRelationshipToken *token = [[DVYRelationshipToken alloc] initWithUser:user campaign:self];
//    }
//    
//    NSSortDescriptor *sortByMinimumDescending = [NSSortDescriptor sortDescriptorWithKey:@"minimum" ascending:NO];
//}



@end
