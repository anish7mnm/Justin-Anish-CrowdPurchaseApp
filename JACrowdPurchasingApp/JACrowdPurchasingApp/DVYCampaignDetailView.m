//
//  DVYCampaignDetailView.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/25/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYCampaignDetailView.h"
#import "DVYCampaign.h"

@implementation DVYCampaignDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)createACampaignPageWithTitle:(NSString *)title Details:(NSString *)details Host:(DVYUser *)host PeopleCommited:(NSNumber *)peopleCommited PeopleNeeded:(NSNumber *)peopleNeeded Deadline:(NSDate *)deadline ProfilePicture:(UIImage *)profilePicture
{
    DVYCampaign *newCampaign = [[DVYCampaign alloc] initWithTitle:title detail:details deadline:deadline host:host minimumNeededCommits:[peopleNeeded integerValue]];
    [newCampaign addCommitter:host];
}


@end
