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


@dynamic title;
@dynamic detail;
@dynamic deadline;
@dynamic host;
@dynamic minimumNeededCommits;
@dynamic committed;
@dynamic invitees;
@dynamic hasEnded;
@dynamic hasMetNeeds;
@dynamic item;
@dynamic committedCount;



+(NSString *)parseClassName
{
    return @"Campaign";
}

//-(void)setCommittedCount:(NSNumber *)committedCount{
//    PFQuery *query = [self.committed query];
//    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
//        NSInteger committedNumber = (NSInteger)number;
//        _committedCount = @(committedNumber);
//    }];}

//- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail deadline:(NSDate *)deadline host:(DVYUser *)host minimumNeededCommits:(NSNumber *)minimumNeededCommits
//{
//    self = [[DVYCampaign alloc] init];
//    if (self) {
//        _title = title;
//        _detail = detail;
//        _deadline = deadline;
//        _host = host;
//        _minimumNeededCommits = minimumNeededCommits;
//        //_price = @(0);
//        
//        _invitees = [[NSMutableArray alloc] init];
//        _committed = [[NSMutableArray alloc] init];
//        //_watchers = [[NSMutableArray alloc] init];
//
//        //_tokens = [[NSMutableArray alloc] init];
//        //[_tokens addObject:[self generateHostToken]];
//        //[_watchers addObject:[self generateHostToken]];
//        
//        _hasEnded = NO;
//    }
//    
//    return self;
//}

//- (DVYRelationshipToken *)generateHostToken
//{
//    DVYRelationshipToken *hostToken = [[DVYRelationshipToken alloc] initWithUser:self.host campaign:self];
//    hostToken.minimumDesiredCommits = self.minimumNeededCommits;
//    
//    return hostToken;
//}


//Adding a bunch of people
- (void)addInvitees:(NSArray *)invitees
{
    for (DVYUser *invitee in invitees) {
        [self.invitees addObject:invitee];
    }
}


//Adding one user
- (void)addInvitee:(DVYUser *)inviteeToAdd
{
    [self.invitees addObject:inviteeToAdd];
}


//Remove a user
- (void)removeInvitee:(DVYUser *)inviteeToRemove
{
    [self.invitees removeObject:inviteeToRemove];
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


//Commit a bunch of people
- (void)addCommitted:(NSArray *)committed
{
    for (DVYUser *committer in committed)
    {
        [self.committed addObject:committer];
    }
    [self saveInBackground];
    [self checkIfCampiagnHasMetNeeds];

}


//Commit one user
- (void)addCommitter:(DVYUser *)committer
{
    [self.committed addObject:committer];
    [self saveInBackground];
    [self checkIfCampiagnHasMetNeeds];
    
}


//Uncommit a user
- (void)removeCommitter:(DVYUser *)committer
{
    [self.committed removeObject:committer];
    [self saveInBackground];

}


//Campaign has met the needs of minimum number of people
-(void)checkIfCampiagnHasMetNeeds{
    [self requestCommitWithCompletionBlock:^(NSArray *campaignObjects) {
        if ([campaignObjects count] >= [self.minimumNeededCommits integerValue]) {
            self.hasMetNeeds = YES;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"CONGRATULATIONS!"
                                                            message:@"YOUR CAMPAIGN NEEDS ARE MET"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
            [self saveInBackground];
        }
    }];
    
}



-(void) requestCommitWithCompletionBlock: (void (^)(NSArray *campaignObjects)) completionBlock
{
    PFQuery *query = [self.committed query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        completionBlock(objects);
    }];
}


- (void)setHasEnded
{
    self.hasEnded = YES;
}


//- (void)addTokenWithUser:(DVYUser *)user minimumDesiredCommit:(NSInteger)integer
//{
//    DVYRelationshipToken *token = [[DVYRelationshipToken alloc] initWithUser:user campaign:self];
//    token.minimumDesiredCommits = integer;
//    [_tokens addObject:token];
//}
//
//- (void)removeTokenWithUser:(DVYUser *)user
//{
//    for (DVYRelationshipToken *token in self.tokens) {
//        if (token.user == user) {
//            [self.tokens removeObject:token];
//        }
//    }
//}



//- (void)runAutoCommit
//{
//    [self sortTokens];
//    NSMutableArray *tokensToConsider = [self.tokens copy];
//    
//    for (DVYRelationshipToken *token in self.tokens) {
//        
//        NSInteger highestMinimumCommitToConsider = [self highestMinimumCommitInArray:tokensToConsider];
//        NSMutableArray *arrayOfCompatibleTokens = [self arrayOfTokensWithMinimumAtOrLessThan:highestMinimumCommitToConsider inArray:tokensToConsider];
//        
//        if ([arrayOfCompatibleTokens count]>highestMinimumCommitToConsider) {
//            for (DVYRelationshipToken *token in arrayOfCompatibleTokens) {
//                token.isCommitted = YES;
//                self.committed = arrayOfCompatibleTokens;
//            }
//            continue;
//        }
//        else {
//            [tokensToConsider removeObjectAtIndex:0];
//        }
//    }
//    
//}



//- (NSMutableArray *)arrayOfTokensWithMinimumAtOrLessThan:(NSInteger)minimum inArray:(NSArray *)array
//{
//    NSMutableArray *arrayToReturn = [[NSMutableArray alloc] init];
//    
//    for (DVYRelationshipToken *token in array) {
//        if (token.minimumDesiredCommits <= minimum) {
//            [arrayToReturn addObject:token];
//        }
//    }
//    
//    return arrayToReturn;
//}



//- (NSInteger)highestMinimumCommitInArray:(NSArray *)array
//{
//    NSInteger highest = 0;
//    
//    for (DVYRelationshipToken *token in array) {
//        if (token.minimumDesiredCommits > highest) {
//            highest = token.minimumDesiredCommits;
//        }
//    }
//    
//    return highest;
//}



//- (void)sortTokens
//{
//    NSSortDescriptor *sortByDescendingMinimumCommits = [NSSortDescriptor sortDescriptorWithKey:@"minimumDesiredCommits" ascending:NO];
//    self.tokens = [[self.tokens sortedArrayUsingDescriptors:@[sortByDescendingMinimumCommits]] mutableCopy];
//}


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
