//
//  DVYCommittedFriendsCollectionViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 4/18/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <Parse/Parse.h>

#import "DVYBasicAPIClient.h"

#import "DVYCommittedFriendsCollectionViewController.h"
#import "FriendCollectionViewCell.h"
#import "DVYCampaign.h"
#import "DVYUser.h"


@interface DVYCommittedFriendsCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *friendsCollection;

@end


@implementation DVYCommittedFriendsCollectionViewController


#pragma mark - View Lifecycle


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self settingUpCollectionViewCell];
    
}


#pragma mark - View Helper Methods

- (void)settingUpCollectionViewCell
{
    [self.friendsCollection registerNib:[UINib nibWithNibName:@"FriendCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"friendCell"];
    
    self.friendsCollection.delegate = self;
    
    self.friendsCollection.dataSource = self;
}


#pragma mark - UICollcetionViewDataSource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.committedUsers count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    FriendCollectionViewCell *cell = [self.friendsCollection dequeueReusableCellWithReuseIdentifier:@"friendCell" forIndexPath:indexPath];
    
    DVYUser *committer = self.committedUsers[indexPath.row];
    
    NSString *userProfilePhotoURLString = committer[@"profilePicture"];
    
    if (userProfilePhotoURLString)
    {
        
        [DVYBasicAPIClient fetchingImageFromUserProfilePictureLinkString:userProfilePhotoURLString withSuccessBlock:^(NSData *imageData) {
            
            cell.friendProfilePicture.image = [UIImage imageWithData:imageData];
            
        } failureBlock:^{
            
            cell.friendProfilePicture.image = [UIImage imageNamed:@"default"];
            
        }];
        
    }
    else
    {
        cell.friendProfilePicture.image = [UIImage imageNamed:@"default"];
    }
    
    return cell;
    
}


#pragma mark - UIButtonAction

- (IBAction)backButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
