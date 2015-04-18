//
//  DVYCommittedFriendsCollectionViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 4/18/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYCommittedFriendsCollectionViewController.h"
#import "FriendCollectionViewCell.h"


@interface DVYCommittedFriendsCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *friendsCollection;

@end

@implementation DVYCommittedFriendsCollectionViewController


#pragma mark - View Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.friendsCollection registerNib:[UINib nibWithNibName:@"FriendCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"friendCell"];
    
    self.friendsCollection.delegate = self;
    self.friendsCollection.dataSource = self;
    
}


#pragma mark - UICollcetionViewDataSource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FriendCollectionViewCell *cell = [self.friendsCollection dequeueReusableCellWithReuseIdentifier:@"friendCell" forIndexPath:indexPath];
    
    cell.friendProfilePicture.image = [UIImage imageNamed:@"default"];
    
    return cell;
    
}


@end
